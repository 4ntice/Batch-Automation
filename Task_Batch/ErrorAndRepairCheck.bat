@echo off
:: Check for admin rights
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else (
goto gotAdmin
)

:UACPrompt
:: Create a temporary VBS to request elevation
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %*", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs"

:: Your elevated commands here
title Administrator Command Prompt

cd /d "%~dp0"

pause

sfc /scannow

DISM.exe /Online /Cleanup-image /Restorehealth

chkdsk C: /f /r

echo After you press Enter the system will restart.

pause

shutdown -r -t 0

cmd

