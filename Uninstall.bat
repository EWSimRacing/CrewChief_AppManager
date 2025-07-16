@echo off
:: Self-elevate if not already running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: Run the PowerShell uninstall script
SET script_dir=%~dp0
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%script_dir%Uninstall_CrewChief_AppManager.ps1'"

exit
