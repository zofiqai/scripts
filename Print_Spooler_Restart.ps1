# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# This script stops the Print Spooler service, removes all print jobs, and then restarts the Print Spooler service.
# It is designed to work on all versions of Windows, including Server-based operating systems.

# Function to stop the Print Spooler service
function Stop-PrintSpooler {
    Write-Host "Stopping the Print Spooler service..."
    Stop-Service -Name "Spooler" -Force -ErrorAction Stop
    Write-Host "Print Spooler service stopped."
}

# Function to delete all print queues
function Delete-PrintQueues {
    Write-Host "Deleting all print queues..."

    $spoolDirectory = "$env:SystemRoot\System32\spool\PRINTERS"
    if (Test-Path $spoolDirectory) {
        Remove-Item "$spoolDirectory\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "All print queues deleted."
    } else {
        Write-Host "Failed to find the spool directory." -ForegroundColor Red
    }
}

# Function to start the Print Spooler service
function Start-PrintSpooler {
    Write-Host "Starting the Print Spooler service..."
    Start-Service -Name "Spooler" -ErrorAction Stop
    Write-Host "Print Spooler service started."
}

# Execute the functions
Stop-PrintSpooler
Delete-PrintQueues
Start-PrintSpooler

Write-Host "Script execution completed."
