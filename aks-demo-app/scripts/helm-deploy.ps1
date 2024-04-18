$chartname= "demo-chart" 
$prompt = Read-Host "Chartname, default[$($chartname)]"
$chartname = ($chartname,$prompt)[[bool]$prompt]
Write-Host "using chart $chartname"

$chartversion= "1.0.1"
$prompt = Read-Host "Chartversion, default[$($chartversion)]"
$chartversion = ($chartversion,$prompt)[[bool]$prompt]
Write-Host "using chartversion $chartversion"

$chart = "helm/$chartname"
$targetEnv = "test"
$apps = @('demo-api','demo-app')
$acrRegistry = "acrweuvecozodemo"
$acrRegistryFull = "oci://$acrRegistry.azurecr.io"

$currentDir = @(Get-Location).Path
$rootDir = @(Get-Location).Path
if ($rootDir -match "scripts"){
    Set-Location ..
    $rootDir = @(Get-Location).Path
}    

try {        
    $install = New-Object System.Management.Automation.Host.ChoiceDescription '&Install', 'Install'
    $upgrade = New-Object System.Management.Automation.Host.ChoiceDescription '&Upgrade', 'Upgrade'
    $uninstall = New-Object System.Management.Automation.Host.ChoiceDescription '&Remove', 'Remove'
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($install, $upgrade, $uninstall)

    $result = $host.ui.PromptForChoice('Deploy mode','What is the deployment mode?', $options, 1)

    switch ($result) {
        0 { $mode = "install" }
        1 { $mode = "upgrade" }
        2 { $mode = "uninstall" }
        Default { $mode = "install" }
    }

    foreach($app in $apps){
        switch ($mode) {
            "uninstall" { 
                helm uninstall $app
            }
            Default {
                # exectute the helm install or upgrade. we pass in a base set of variables and depending on the environment we target we pass in a environment specific file
                # note that these variables shouls not be the secrets, these should be passed stored as a k8s secret.
                Write-Host "helm $mode $app `"$acrRegistryFull/$chart`" -f `"$rootDir\deployment\$app\base.yaml`" -f `"$rootDir\deployment\$app\$targetEnv.yaml`" --version $chartVersion --timeout `"5m0s`" --description $app" -BackgroundColor Gray           
                Read-Host
                helm $mode $app "$acrRegistryFull/$chart" -f "$rootDir\deployment\$app\base.yaml" -f "$rootDir\deployment\$app\$targetEnv.yaml" --version $chartVersion --timeout "5m0s" --description $app
            }
        }
    }
}
finally {
    Set-Location $currentDir
}
