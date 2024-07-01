# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# The script modifies the registry settings to increase the maximum size limit for both PST and OST files to 100GB, but warn the user at 95GB.
# It works on all versions of Windows where Outlook is installed.


# Function to set registry value
function Set-RegistryValue {
    param (
        [string]$Path,
        [string]$Name,
        [string]$Value
    )
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }
    Set-ItemProperty -Path $Path -Name $Name -Value $Value -Force
}

# Function to increase Outlook PST/OST size limit
function Increase-OutlookSizeLimit {
    Write-Host "Increasing Outlook PST/OST size limit to 100GB..."

    $pstPath = "HKCU:\Software\Microsoft\Office\16.0\Outlook\PST"
    $ostPath = "HKCU:\Software\Microsoft\Office\16.0\Outlook\OST"
    $maxSize = 100GB
    $maxFileSize = [math]::Round($maxSize / 1MB)

    # Setting values for PST
    Set-RegistryValue -Path $pstPath -Name "MaxLargeFileSize" -Value $maxFileSize
    Set-RegistryValue -Path $pstPath -Name "WarnLargeFileSize" -Value ($maxFileSize - 5GB)

    # Setting values for OST
    Set-RegistryValue -Path $ostPath -Name "MaxLargeFileSize" -Value $maxFileSize
    Set-RegistryValue -Path $ostPath -Name "WarnLargeFileSize" -Value ($maxFileSize - 5GB)

    Write-Host "Outlook PST/OST size limit increased to 100GB."
}

# Execute the function
Increase-OutlookSizeLimit

Write-Host "Script execution completed."
