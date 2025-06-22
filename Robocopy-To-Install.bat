@echo off
:: Robocopy-To-Install.bat
:: https://github.com/ZeroErrors/robocopy-to
::
:: Adds the “Robocopy to…” context-menu entry that
:: lets you right-click any folder and launch Robocopy-To.ps1
:: against it.
::

setlocal EnableDelayedExpansion

rem -------- script constants -----------------------------------------------
set "BASEKEY=HKCU\Software\Classes\Directory\shell\RobocopyTo"
set "CMDKEY=%BASEKEY%\command"
set "ICON=%SystemRoot%\System32\robocopy.exe,0"

rem Full path to the PowerShell helper (quoted, with back-ticks escaped)
set "PS1=%~dp0Robocopy-To.ps1"
set "PS1_ESC=%PS1:\=\\%"
set "CMD=powershell.exe -ExecutionPolicy Bypass -File \"%PS1_ESC%\" \"%%1\""

rem ----------- INSTALL --------------------------------------------------
echo Creating registry keys...

rem Create the keys
reg add "%BASEKEY%" /f >nul
reg add "%CMDKEY%"  /f >nul

rem Set menu text and icon
reg add "%BASEKEY%" /ve /d "Robocopy to..." /t REG_SZ          /f >nul
reg add "%BASEKEY%" /v  Icon /d "%ICON%"  /t REG_SZ          /f >nul

rem Command: run the helper in a new PowerShell window, passing the folder (%1)
rem Use REG_EXPAND_SZ so %SystemRoot% stays expandable
reg add "%CMDKEY%" /ve /t REG_EXPAND_SZ /d "%CMD%" /f >nul

echo Robocopy context-menu entry installed.

echo(
echo You may need to restart any open File Explorer windows to see the change.
endlocal
pause
exit /b
