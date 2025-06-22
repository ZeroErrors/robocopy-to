<#
.SYNOPSIS
  Adds or removes the “Robocopy to…” context-menu entry.
  -Uninstall → Uninstalls the context menu entry.
#>

param(
    [switch]$Uninstall
)

$baseKey   = 'HKCU:\Software\Classes\Directory\shell\RobocopyTo'
$cmdKey    = "$baseKey\command"
$script    = Join-Path $PSScriptRoot 'Robocopy-To.ps1'

if ($Uninstall) {
    if (Test-Path $baseKey) {
        Remove-Item $baseKey -Recurse -Force
        Write-Host "✔ Robocopy context menu removed."
    } else {
        Write-Host "Nothing to remove - entry not found."
    }
} else {
    Write-Verbose "Creating $baseKey …"
    New-Item      $baseKey      -Force | Out-Null
    New-Item      $cmdKey       -Force | Out-Null

    Set-ItemProperty $baseKey -Name '(default)' -Value 'Robocopy to…'
    Set-ItemProperty $baseKey -Name 'Icon'      -Value '%SystemRoot%\System32\robocopy.exe,0'
    # uncomment next line if you only want it when Shift is held
    # New-ItemProperty $baseKey -Name 'Extended' -PropertyType String -Value ''

    # REG_EXPAND_SZ so %SystemRoot% expands & we can use env vars later if wanted
    New-ItemProperty $cmdKey -Name '(default)' `
        -Value "powershell.exe -NoExit -ExecutionPolicy Bypass -File `"$script`" `"%1`"" `
        -PropertyType ExpandString -Force  | Out-Null

    Write-Host "✔ Robocopy context menu installed."
}

Write-Host "`nRestart any open Explorer windows to see the change."
