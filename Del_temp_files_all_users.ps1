# Delete temporary files for all users
# Created by zofiQ Inc.
# Always test in a non-production environment prior to deploying to a live system that is in production!

# This script will:
# 1. Disable the Windows Update Service to ensure it doesn't interfere with the deletion process.
# 2. Delete temporary files from the Windows Temp folder.
# 3. Iterate through all user profiles and delete temporary files in each user's Temp folder.

# Function to delete temporary files
function Remove-TemporaryFiles {
    Write-Host "Deleting temporary files..."

    # Delete Windows Temp files
    $windowsTemp = "$env:SystemRoot\Temp"
    if (Test-Path $windowsTemp) {
        Remove-Item "$windowsTemp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Deleted files in $windowsTemp"
    }

    # Delete Temp files for all user profiles
    $userProfiles = Get-WmiObject -Class Win32_UserProfile | Where-Object { $_.Special -eq $false }
    foreach ($profile in $userProfiles) {
        $tempPath = "$($profile.LocalPath)\AppData\Local\Temp"
        if (Test-Path $tempPath) {
            Remove-Item "$tempPath\*" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Deleted files in $tempPath for user $($profile.LocalPath)"
        }
    }
}

# Function to disable Windows Update Service
function Disable-WindowsUpdateService {
    Write-Host "Disabling Windows Update Service..."
    Stop-Service -Name wuauserv -Force
    Set-Service -Name wuauserv -StartupType Disabled
    Write-Host "Windows Update Service has been disabled."
}

# Execute the functions
Disable-WindowsUpdateService
Remove-TemporaryFiles

Write-Host "Script execution completed."
