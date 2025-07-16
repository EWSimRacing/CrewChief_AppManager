# Uninstall_CrewChief_AppManager.ps1

$taskName = "CrewChief App Manager"
$logFile = Join-Path -Path $PSScriptRoot -ChildPath "CrewChief_AppManager.log"

try {
    if (Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        Write-Output "Task '$taskName' has been removed."
    } else {
        Write-Output "No task named '$taskName' was found."
    }

    if (Test-Path $logFile) {
        Remove-Item $logFile -Force
        Write-Output "Log file removed: $logFile"
    }

    Write-Output "Uninstallation complete. You may now delete this folder."
}
catch {
    Write-Output "Uninstall failed: $_"
}
