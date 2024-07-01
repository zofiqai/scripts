# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# The script modifies the registry to enable USB storage devices. It works on all versions of Windows, including Server-based operating systems.

# Function to enable USB storage devices
function Enable-USBStorage {
    Write-Host "Enabling USB storage devices..."

    # Define the registry path and value
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR"
    $regName = "Start"
    $regValue = 3

    # Check if the registry key exists
    if (Test-Path $regPath) {
        try {
            # Set the registry value to enable USB storage
            Set-ItemProperty -Path $regPath -Name $regName -Value $regValue
            Write-Host "USB storage devices have been enabled."
        } catch {
            Write-Host "Failed to enable USB storage devices. Please ensure you are running this script with administrative privileges." -ForegroundColor Red
        }
    } else {
        Write-Host "The registry path $regPath does not exist." -ForegroundColor Red
    }
}

# Execute the function
Enable-USBStorage

Write-Host "Script execution completed."
