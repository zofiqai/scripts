# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# The script retrieves all event logs and clears each one.
# It is designed to work on all versions of Windows, including Server-based operating systems.

# Function to clear all event logs
function Clear-AllEventLogs {
    Write-Host "Clearing all event logs..."

    # Get all event logs
    $eventLogs = Get-EventLog -LogName *

    # Clear each event log
    foreach ($log in $eventLogs) {
        try {
            Clear-EventLog -LogName $log.Log
            Write-Host "Cleared event log: $($log.Log)"
        } catch {
            Write-Host "Failed to clear event log: $($log.Log)" -ForegroundColor Red
        }
    }

    Write-Host "All event logs have been cleared."
}

# Execute the function
Clear-AllEventLogs

Write-Host "Script execution completed."
