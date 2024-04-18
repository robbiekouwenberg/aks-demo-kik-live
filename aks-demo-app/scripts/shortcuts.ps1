Set-Alias -Name k -Value kubectl
Set-Alias -Name np -Value C:\Windows\notepad.exe
function GetPods
{
    param (
        [string]$namespace=”default”,
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )  
 kubectl get pods -n $namespace $args
}
Set-Alias -Name kgp -Value GetPods
function GetPodsWide
{
    param (
        [string]$namespace=”default”,
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )  
 kubectl get pods -n $namespace -o wide $args
}
Set-Alias -Name kgpw -Value GetPods
function GetAll
{
    param (
        [string]$namespace=”default”,
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )  
 kubectl get all -n $namespace $args
}
Set-Alias -Name kgall -Value GetAll
function GetNodes()
{
 kubectl get nodes -o wide
}
Set-Alias -Name kgn -Value GetNodes
function DescribePod
{
    param (
        [string]$container, 
        [string]$namespace=”default”,
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )  
 kubectl describe po $container -n $namespace $args
}
Set-Alias -Name kdp -Value DescribePod
function GetLogs
{
    param (
        [string]$container, 
        [string]$namespace=”default”,
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )   
 kubectl logs pod/$container -n $namespace $args
}
Set-Alias -Name kl -Value GetLogs
function ApplyYaml([string]$filenamer, [string]$namespace=”default”)
{
 kubectl apply -f $filename -n $namespace
}
Set-Alias -Name kaf -Value ApplyYaml
function ExecContainerShell
{
    param (
        [string]$container, 
        [string]$namespace=”default”,
        [String] $tool = 'ash',
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )  
 kubectl exec -it $container $tool -n $namespace $args
}
Set-Alias -Name kexec -Value ExecContainerShell
function GetLoadBalancerIP
{
    param (
        [string]$serviceName, 
        [string]$namespace=”default”,
        [Parameter(
            ValueFromRemainingArguments=$true
        )][string[]]
        $args
    )   
 kubectl get svc -n $namespace $serviceName --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}" $args
}
Set-Alias -Name ksip -Value GetLoadBalancerIP