[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $clusterName,

    [Parameter()]
    [string]
    $nodegroupName,

    [Parameter()]
    $taints
)

$ErrorActionPreference = "Stop"
$InformationPreference = "Continue"
$WarningPreference = "SilentlyContinue"
function CommandAliasFunction {
    Write-Information ""
    Write-Information "$args"
    $cmd, $args = $args
    $params = $args -split " "
    & "$cmd" @params
    if ($LASTEXITCODE) {
        throw "Exception Occured"
    }
    Write-Information ""
}

Set-Alias -Name ce -Value CommandAliasFunction -Scope script

$taints = $taints | ConvertFrom-Json

$taintsCmdInput = @{
    clusterName   = $clusterName
    nodegroupName = $nodegroupName
    taints        = @{
        addOrUpdateTaints = @()
        removeTaints      = @()
    }
}

# Add taints
if ($taints.Count -gt 0) {
    $addTaintsCmdInput = $taintsCmdInput
    foreach ($i in $taints) {
        $addTaintsCmdInput.taints.addOrUpdateTaints += $i
    }
    $addTaintsCmdInputJson = $addTaintsCmdInput | ConvertTo-Json -Depth 5 -Compress
    Set-Content -Path addTaints.json $addTaintsCmdInputJson
    Write-Output "______addOrUpdateTaints_______"
    Write-Output $addTaintsCmdInputJson
    ce aws eks update-nodegroup-config --profile $Env:AWS_PROFILE --cli-input-json file://addTaints.json
    Remove-Item -Path addTaints.json
}

# Remove taints not provided in input
$removeTaintsCmdInput = $taintsCmdInput
$ngConfig = ce aws eks describe-nodegroup --cluster-name $clusterName --nodegroup-name $nodegroupName --output json --profile $Env:AWS_PROFILE
$ngConfig = $ngConfig | ConvertFrom-Json
$existingTaints = $ngConfig.nodegroup.taints
Write-Output "existingTaints"
Write-Output $existingTaints
if ($taints.Count -gt 0 -and $existingTaints.Count -gt 0 ) {
    $taintsToRemove = Compare-Object -ReferenceObject $taints -DifferenceObject $existingTaints -Property key -PassThru
    $taintsToRemove | ForEach-Object {
        Write-Output $_
        $_.PSObject.Properties.Remove('SideIndicator')
    }
}
else {
    $taintsToRemove = $existingTaints
}

if ($taintsToRemove.Length -gt 0) {
    foreach ($i in $taintsToRemove) {
        $removeTaintsCmdInput.taints.removeTaints += $i
    }
    # If there have been taint updates, wait for node to return to active state
    if ($removeTaintsCmdInput.taints.addOrUpdateTaints.Length -gt 0 ) {
        Start-Sleep -Seconds 15
    }
    $removeTaintsCmdInputJson = $removeTaintsCmdInput | ConvertTo-Json -Depth 5 -Compress
    Write-Output "______removeTaints_______"
    Write-Output $removeTaintsCmdInputJson
    Set-Content -Path removeTaints.json $removeTaintsCmdInputJson
    ce aws eks update-nodegroup-config --profile $Env:AWS_PROFILE --cli-input-json file://removeTaints.json
    Remove-Item -Path removeTaints.json
}