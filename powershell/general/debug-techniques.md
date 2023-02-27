Taking as example the following script:

```bash
$BUILDS_API_URL =
"$env:SYSTEM_COLLECTIONURI$env:SYSTEM_TEAMPROJECT/_apis/build/builds/
$env:BUILD_BUILDID"
function Get-PipelineArtifact {
param($Name)
try {
Write-Debug "Getting pipeline artifact for: $Name"
$res = Invoke-RestMethod "$BUILDS_API_URL)artifacts?api-version=6.0"
? -Headers @{
Authorization = "Bearer $env:SYSTEM_ACCESSTOKEN"
} -MaximumRetryCount 5 -RetryIntervalSec 1
if (!$res) {
Write-Debug 'We did not receive a response from the Azure
? Pipelines builds API.'
return
}
$res.value | Where-Object { $_.name -Like $Name }
} catch {
Write-Warning $_
}
}
# Determine which stages we care about
$stages = @(
if ($env:VSCODE_BUILD_STAGE_WINDOWS -eq 'True') { 'Windows' }
if ($env:VSCODE_BUILD_STAGE_LINUX -eq 'True') { 'Linux' }
if ($env:VSCODE_BUILD_STAGE_OSX -eq 'True') { 'macOS' }
)
Write-Debug "Running on the following stages: $stages"
Write-Host 'Starting...' -ForegroundColor Green
$stages | ForEach-Object {
$artifacts = Get-PipelineArtifact -Name "vscode-$_"
foreach ($artifact in $artifacts) {
$artifactName = $artifact.name
$artifactUrl = $artifact.resource.downloadUrl
Write-Debug "Downloading artifact from $artifactUrl to
Temp:/$artifactName.zip"
Invoke-RestMethod $artifactUrl -OutFile "Temp:/$artifactName.zip"
? -Headers @{
Authorization = "Bearer $env:SYSTEM_ACCESSTOKEN"
} -MaximumRetryCount 5 -RetryIntervalSec 1 | Out-Null
Expand-Archive -Path "Temp:/$artifactName.zip" -DestinationPath
? 'Temp:/' | Out-Null
}
}
Write-Host 'Done!' -ForegroundColor Green
```

If we ran it normally it would display:

```bash
/publishing.ps1
Starting...
Done!
```

If we set `$DebugPreference = 'Continue'` , we would be able to see the debug stream while it's running, like:

```bash
./publishing.ps1
Starting...
DEBUG: Running on the following stages: Windows Linux
DEBUG: Getting pipeline artifact for: vscode-Windows
DEBUG: Downloading artifact from <redacted> to Temp:/vscode-windows-release.zip
DEBUG: Getting pipeline artifact for: vscode-Linux
DEBUG: Downloading artifact from <redacted> to Temp:/vscode-linux-release.zip
Done!
```

Although this way is tedious because you need to wait until the exact line you want to debug to be executed, we can bypass this using `F8 Debugging` or `line-by-line debugging`

Taking for example the script:

```bash
Write-Host 'hello'
$processName = 'pwsh'
Get-Process $processName
```

We paste/open it on visual studio code and with the PowerShell extension it will take the current line and run it on the integrated console.

We then set our cursor on the first line of the script and we use the `Run and Run Selection` and it will run the snippet we selected or the current line.

By running line-by-line it will keep the current state saved on the console, meaning we can debug our script by seeing what's happening while it's happening.

We can get a clean state of PowerShell by running ctrl+shift+P and then typing `PowerShell: Restart Current Session` on the command palette

There's also a way of debugging called breakpoint debugging, which works by making us select a break point (dot in vscode), then `running with debug`, and the script will run up until the breakpoint. On the left side of vs code, we will get tabs with varable states at the time of stopping at the breakpoint and the console will show  "[DBG]" to indicate that  it's currently debugging a script


