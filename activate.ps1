# Run from PowerShell with: .\activate.ps1
$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$prologBin = Join-Path $repoRoot '.local-tools\swipl\bin'
$erlangBins = @(
    (Join-Path $env:USERPROFILE '.elixir-install\installs\otp\29.1.2\bin'),
    'C:\Program Files\Erlang OTP\bin'
)
$elixirBins = @(
    (Join-Path $env:USERPROFILE '.elixir-install\installs\elixir\1.20.5-otp-29\bin'),
    'C:\Program Files\Elixir\bin'
)
$runtimeTemp = Join-Path $repoRoot '.local-tools\temp'

# Use the repository's optional SWI-Prolog bundle when present; otherwise keep
# the current PATH installation (for example, C:\Program Files\swipl\bin).
if (Test-Path -LiteralPath $prologBin -PathType Container) {
    $env:PATH = "$prologBin;$env:PATH"
} elseif (-not (Get-Command swipl -ErrorAction SilentlyContinue)) {
    throw "SWI-Prolog was not found. Install it or add its bin folder to PATH."
}

# Add the pinned user-level Erlang/Elixir installation when available. If it is
# absent, preserve any installation already available on PATH.
$runtimeBins = @()
foreach ($directory in @($erlangBins + $elixirBins)) {
    if (Test-Path -LiteralPath $directory -PathType Container) {
        $runtimeBins += $directory
    }
}
if ($runtimeBins.Count -gt 0) {
    $env:PATH = @($runtimeBins + $env:PATH) -join ';'
}
if (-not (Get-Command mix -ErrorAction SilentlyContinue) -or
    -not (Get-Command elixir -ErrorAction SilentlyContinue)) {
    Write-Warning 'Elixir and Erlang are not available. Install Elixir (including Erlang/OTP), then open a new PowerShell session.'
} else {
    Write-Host 'SWI-Prolog, Erlang, and Elixir are available in this PowerShell session.'
}

New-Item -ItemType Directory -Force -Path $runtimeTemp | Out-Null
$env:TEMP = $runtimeTemp
$env:TMP = $runtimeTemp
