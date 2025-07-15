<#
===============================================
 EWSimTools: Crew Chief Auto Manager v1.0
 Developed by Elliott Williams (@EWSimRacing)
 www.instagram.com/ewsimracing
===============================================
#>

$SimProcessNames = @(
    "Le Mans Ultimate",
    "iRacingSim64DX11",
    "AC2-Win64-Shipping",
    "acs",
    "AssettoCorsaEvo",
    "AMS2AVX",
    "rfactor2",
    "RRRE64",
    "forza_gaming.desktop.x64_release_final",
    "F1_2024",
    "F1_2025"
)

$CrewChiefProcessName = "CrewChiefV4"
$CrewChiefPath = "C:\Program Files (x86)\Britton IT Ltd\CrewChiefV4\CrewChiefV4.exe"
$LogPath = Join-Path -Path $PSScriptRoot -ChildPath "CrewChief_AutoManager.log"
$crewChiefLaunched = $false
$sleepInterval = 5

function Write-Log {
    param ([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Add-Content -Path $LogPath -Value "[$timestamp] $message"
}

Write-Log "Script started."

while ($true) {
    $isAnySimRunning = $false
    foreach ($simName in $SimProcessNames) {
        if (Get-Process -Name $simName -ErrorAction SilentlyContinue) {
            $isAnySimRunning = $true
            Write-Log "Detected sim running: $simName"
            break
        }
    }

    $isCrewChiefRunning = Get-Process -Name $CrewChiefProcessName -ErrorAction SilentlyContinue

    if ($isAnySimRunning) {
        if (-not $isCrewChiefRunning -and -not $crewChiefLaunched) {
            if (Test-Path $CrewChiefPath) {
                Start-Sleep -Seconds 10
                Start-Process -FilePath $CrewChiefPath
                Write-Log "Crew Chief launched."
                $crewChiefLaunched = $true
                $sleepInterval = 60
            } else {
                Write-Log "ERROR: Crew Chief path not found: $CrewChiefPath"
            }
        }
    }
    else {
        if ($isCrewChiefRunning -and $crewChiefLaunched) {
            Stop-Process -Name $CrewChiefProcessName -Force
            Write-Log "Crew Chief auto-closed (no sims running)."
            $crewChiefLaunched = $false
            $sleepInterval = 5
        }
    }

    Start-Sleep -Seconds $sleepInterval
}
