# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# The script modifies the registry settings to disable UAC. The changes will be effective until the next system reboot.

# Function to disable UAC until next reboot
function Disable-UAC {
    Write-Host "Disabling User Account Control (UAC) until next reboot..."

    # Define the registry path and value
    $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
    $regName = "EnableLUA"
    $regValue = 0

    try {
        # Backup the current value of EnableLUA
        $currentValue = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop
        Set-ItemProperty -Path $regPath -Name "EnableLUA_Backup" -Value $currentValue.EnableLUA -ErrorAction Stop
        
        # Set the registry value to disable UAC
        Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -ErrorAction Stop
        Write-Host "User Account Control (UAC) has been disabled until next reboot."
    } catch {
        Write-Host "Failed to disable User Account Control (UAC). Please ensure you are running this script with administrative privileges." -ForegroundColor Red
    }
}

# Function to restore UAC on next reboot
function Restore-UAC {
    Write-Host "Restoring User Account Control (UAC) on next reboot..."

    # Add a scheduled task to restore UAC on next reboot
    $script = {
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
        $regName = "EnableLUA"
        $backupName = "EnableLUA_Backup"

        if (Test-Path "$regPath\$backupName") {
            $backupValue = Get-ItemProperty -Path $regPath -Name $backupName -ErrorAction Stop
            Set-ItemProperty -Path $regPath -Name $regName -Value $backupValue.$backupName -ErrorAction Stop
            Remove-ItemProperty -Path $regPath -Name $backupName -ErrorAction Stop
            Write-Host "User Account Control (UAC) has been restored to its original state."
        } else {
            Write-Host "Backup of User Account Control (UAC) value not found." -ForegroundColor Red
        }
    }

    $scriptText = $script.ToString().Replace("$(", "$(`").Replace(")", "`)")
    $taskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `$`'$scriptText`$`'"
    $taskTrigger = New-ScheduledTaskTrigger -AtStartup
    $taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    $taskPrincipal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount -RunLevel Highest

    Register-ScheduledTask -TaskName "RestoreUAC" -Action $taskAction -Trigger $taskTrigger -Settings $taskSettings -Principal $taskPrincipal
    Write-Host "Scheduled task created to restore User Account Control (UAC) on next reboot."
}

# Execute the functions
Disable-UAC
Restore-UAC

Write-Host "Script execution completed."
