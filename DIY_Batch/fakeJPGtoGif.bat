@echo off
setlocal

REM Ask for the input file name (must be in the current folder)
set /p input="Enter the name of the input file (with extension): "

REM Check if the input file exists
if not exist "%input%" (
    echo File "%input%" not found.
    exit /b
)

REM Extract the file name without the extension
for %%f in ("%input%") do set "fileName=%%~nf"

REM Generate the output file name with extension
set "output=%fileName%.gif"

ffmpeg -y -i "%input%" "%output%"


REM Check if conversion was successful
if %errorlevel% equ 0 (
	echo Converted to %output%
) else (
    echo Conversion failed.
)

powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\notify.wav').PlaySync();"
pause
