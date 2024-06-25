# PowerShell script to clean C: Drive

# Define a function to empty the Recycle Bin
function Clear-RecycleBin {
    Clear-RecycleBin -Confirm:$false
}

# Function to clear system cache
function Clear-Cache {
    Write-Host "Clearing cache..."
    Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
}

# Function to clean up Windows Update files
function Clean-WindowsUpdate {
    Write-Host "Cleaning Windows Update files..."
    Dism.exe /online /Cleanup-Image /StartComponentCleanup
}

# Execute functions
Clear-RecycleBin
Clear-Cache
Clean-WindowsUpdate

# Create a "done.txt" file on the desktop
$desktopPath = [Environment]::GetFolderPath("Desktop")
$doneFile = Join-Path -Path $desktopPath -ChildPath "done.txt"
New-Item -Path $doneFile -ItemType File -Force

Write-Host "Cleanup operations completed. 'done.txt' file has been created on your desktop."
