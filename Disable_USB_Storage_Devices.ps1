# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# This script modifies the registry to disable USB storage devices. 
# It works on all versions of Windows, including Server-based operating systems.

# Function to disable USB storage devices
function Disable-USBStorage {
    Write-Host "Disabling USB storage devices..."

    # Define the registry path and value
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR"
    $regName = "Start"
    $regValue = 4

    # Check if the registry key exists
    if (!(Test-Path $regPath)) {
        Write-Host "The registry path $regPath does not exist. Creating it..."
        New-Item -Path $regPath -Force | Out-Null
    }

    # Set the registry value to disable USB storage
    try {
        Set-ItemProperty -Path $regPath -Name $regName -Value $regValue
        Write-Host "USB storage devices have been disabled."
    } catch {
        Write-Host "Failed to disable USB storage devices. Please ensure you are running this script with administrative privileges." -ForegroundColor Red
    }
}

# Execute the function
Disable-USBStorage

Write-Host "Script execution completed."
