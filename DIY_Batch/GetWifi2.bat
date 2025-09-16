@echo off
rem This file uses PowerShell to extract the first profile name more flexibly.
setlocal

rem Use PowerShell to parse the netsh output and print the first profile name after a ':'.
for /f "usebackq delims=" %%P in (`powershell -NoProfile -Command ^
  "(netsh wlan show profiles) | ForEach-Object { if ($_ -match '[:]' -and $_ -notmatch '^\s*$') { $t = ($_ -split ':')[-1].Trim(); if ($t) { $t } } } | Select-Object -First 1"`) do set "pf=%%P"

if not defined pf (
  echo No profile found or could not parse profile name.
  echo If your Windows is non-English you may need to adjust the parsing.
  pause
  exit /b 1
)

echo First profile found: "%pf%"
echo.
netsh wlan show profile name="%pf%" key=clear
pause