@echo off
:: Robocopy-To-Uninstall.bat
:: https://github.com/ZeroErrors/robocopy-to
::
:: Removes the “Robocopy to…” context-menu entry that
:: lets you right-click any folder and launch Robocopy-To.ps1
:: against it.
::

setlocal EnableDelayedExpansion

set "BASEKEY=HKCU\Software\Classes\Directory\shell\RobocopyTo"

reg delete "%BASEKEY%" /f >nul 2>&1
if %errorlevel% neq 0 (
    echo Nothing to remove - entry not found.
) else (
    echo Robocopy context-menu entry removed.
)

echo(
echo You may need to restart any open File Explorer windows to see the change.
endlocal
pause
exit /b
