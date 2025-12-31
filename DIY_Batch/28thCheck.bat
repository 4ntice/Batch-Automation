@echo off
REM Reminder BAT for my electricity bill. 28th because every month has 28 days and it takes around 48 hours for the comapany to respond.

REM Use PowerShell to check if today is the 28th
powershell -command "if ((Get-Date).Day -eq 28) { exit 0 } else { exit 1 }"

IF ERRORLEVEL 1 (
    echo Today is not the 28th. Nothing to do.
    exit /b
)

REM Open electricity provider website
start "" "https://Your-Electricity-Provicer.com"

@echo off
echo.
echo ===============================
echo   Electricity bill reminder
echo ===============================
echo.

:loop
powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Alarm09.wav').PlaySync();"
goto loop