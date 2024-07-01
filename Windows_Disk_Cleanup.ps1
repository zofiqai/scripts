# Created by zofiQ Inc.
# Always test in a non-production environment prior to deploying to a live system that is in production!

# This script will:
# This script sets up Disk Cleanup to automatically clean various temporary files and system caches. 
# It uses the /sagerun:1 parameter, which references a predefined set of cleanup tasks in the registry. 
# The registry entries are created for common cleanup tasks, and then Disk Cleanup is run with these settings.

# Function to run Disk Cleanup
function Run-DiskCleanup {
    Write-Host "Running Disk Cleanup..."

    # Define the cleanup options (you can customize this list)
    $cleanupOptions = "/sagerun:1"

    # Create a registry entry for the cleanup options
    $diskCleanupPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"

    $cleanupTasks = @(
        "Active Setup Temp Folders",
        "Downloaded Program Files",
        "Temporary Setup Files",
        "Temporary Internet Files",
        "Recycle Bin",
        "Temporary Files",
        "WebClient/Publisher Temporary Files",
        "Temporary Offline Files",
        "Offline Pages Files",
        "Old Chkdsk Files",
        "Previous Installations",
        "Setup Log Files",
        "System error memory dump files",
        "System error minidump files",
        "Temporary Windows Installation Files",
        "Windows Update Cleanup",
        "Update Cleanup",
        "Service Pack Cleanup",
        "Windows Upgrade Log Files",
        "Downloaded Program Files",
        "User File History"
    )

    foreach ($task in $cleanupTasks) {
        Set-ItemProperty -Path "$diskCleanupPath\$task" -Name "StateFlags0010" -Value 2 -ErrorAction SilentlyContinue
    }

    # Run Disk Cleanup
    Start-Process "cleanmgr.exe" -ArgumentList $cleanupOptions -NoNewWindow -Wait
    Write-Host "Disk Cleanup completed."
}

# Execute the function
Run-DiskCleanup

Write-Host "Script execution completed."
