:: ===============================================
:: EWSimTools: Crew Chief Auto Manager v1.0
:: Developed by Elliott Williams (@EWSimRacing)
:: www.instagram.com/ewsimracing
:: ===============================================

@echo off
:: Self-elevate to admin if not already
:: Credit: https://stackoverflow.com/a/12264592

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator access...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: Get script directory
SET script_dir=%~dp0

:: Run PowerShell installer
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%script_dir%Install_CrewChief_AutoManager.ps1'"

pause
