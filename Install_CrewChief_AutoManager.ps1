# Install_CrewChief_AppManager.ps1

$taskName = "CrewChief App Manager"

# Get the current folder (assuming the script is in same folder)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptPath = Join-Path $scriptDir "CrewChief_AppManager.ps1"

# Sanity check
if (-not (Test-Path $scriptPath)) {
    Write-Host "Could not find CrewChief_AppManager.ps1 in the same folder. Please make sure it's placed next to this installer script."
    exit 1
}

# Define the action to run CrewChief_AutoManager.ps1 at login
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""

# Define the trigger: at logon
$trigger = New-ScheduledTaskTrigger -AtLogOn

# Task settings
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -StartWhenAvailable

# Register the task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Settings $settings -Description "Auto-launches Crew Chief when supported sims are detected." -User $env:USERNAME -RunLevel Highest -Force

# Start the task immediately
Start-ScheduledTask -TaskName $taskName
Write-Host "Task '$taskName' created successfully."
Write-Host "CrewChief_AppManager.ps1 will now launch automatically at login."


