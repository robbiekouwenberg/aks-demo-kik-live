#$imageTag = "1.0.2"
#$imageTag = "2.0.0"
$imageTag = "3.0.0"
$acrRegistry = 'acrweuvecozodemo'
$apps = @(
    'demo-api',
    'demo-app'
     )

$currentDir = @(Get-Location).Path
$rootDir = @(Get-Location).Path
if ($rootDir -match "scripts"){
    Set-Location ..
    $rootDir = @(Get-Location).Path
}    

try {
    # first build the base image
    #az acr build --image "base/dotnet6/aspnet" --registry $acrRegistry --file "docker\base\dotnet6\aspnet\Dockerfile" .

    foreach($app in $apps){
        $image = $app+":$imageTag"
        az acr build --image $image --registry $acrRegistry --file @($app+"\Dockerfile") .
    }
}
finally {
    Set-Location $currentDir
}