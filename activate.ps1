# Run from PowerShell with: .\activate.ps1
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$prologBin = Join-Path $repoRoot '.local-tools\swipl\bin'
$erlangBin = Join-Path $env:USERPROFILE '.elixir-install\installs\otp\29.1.2\bin'
$elixirBin = Join-Path $env:USERPROFILE '.elixir-install\installs\elixir\1.20.5-otp-29\bin'
$runtimeTemp = Join-Path $repoRoot '.local-tools\temp'

foreach ($directory in @($prologBin, $erlangBin, $elixirBin)) {
    if (-not (Test-Path -LiteralPath $directory -PathType Container)) {
        throw "Missing runtime directory: $directory"
    }
}

$env:PATH = @($prologBin, $erlangBin, $elixirBin, $env:PATH) -join ';'
New-Item -ItemType Directory -Force -Path $runtimeTemp | Out-Null
$env:TEMP = $runtimeTemp
$env:TMP = $runtimeTemp
Write-Host 'SWI-Prolog, Erlang, and Elixir are available in this PowerShell session.'
