$chartname= "demo-chart" 
$prompt = Read-Host "Chartname, default[$($chartname)]"
$chartname = ($chartname,$prompt)[[bool]$prompt]
Write-Host "using chart $chartname"

$chartversion= "demoversion.0.1"
$prompt = Read-Host "Chartversion, default[$($chartversion)]"
$chartversion = ($chartversion,$prompt)[[bool]$prompt]
Write-Host "using chartversion $chartversion"

$acrRegistry = "acrweuvecozodemo"
$acrRegistryFull = "$acrRegistry.azurecr.io"

$currentDir = @(Get-Location).Path
$rootDir = @(Get-Location).Path

if ($rootDir -match "scripts"){
    Set-Location ..
    $rootDir = @(Get-Location).Path
}  

try {    
    $packageDir = "$rootDir\.chart-package"
    $chartDir = "$rootDir\chart\$chartname"

    # check the chart for errors
    helm lint "$chartDir"

    # create the actual helm chart package
    helm package "$chartDir" --destination "$packageDir"

    # we use the ACR admin user to be able to push the package
    $login = Read-Host -Prompt "Login to ACR using admin user? y/n"
    if ($login -eq 'y'){
        helm registry login $acrRegistryFull
    }

    # push the created chart package to the ACR in the helm repository
    helm push "$packageDir\$chartname-$chartversion.tgz" "oci://$acrRegistryFull/helm"
}
finally {
    Set-Location $currentDir
}
