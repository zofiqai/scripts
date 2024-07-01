# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# This script finds a local domain controller and synchronizes the computer's time with it.
# If run on a domain controller, it updates the time from Microsoft's time servers using the configured region settings.

# Function to check if the current machine is a domain controller
function Is-DomainController {
    $domainRole = (Get-WmiObject -Class Win32_ComputerSystem).DomainRole
    return ($domainRole -eq 4 -or $domainRole -eq 5)
}

# Function to synchronize time with a domain controller
function Sync-TimeWithDomainController {
    Write-Host "Synchronizing time with the local domain controller..."

    # Find a domain controller
    $domainController = (Get-ADDomainController -Discover -NextClosestSite).HostName

    if ($domainController) {
        # Sync time with the found domain controller
        w32tm /config /manualpeerlist:$domainController /syncfromflags:manual /reliable:YES /update
        w32tm /resync
        Write-Host "Time synchronized with domain controller: $domainController"
    } else {
        Write-Host "Failed to find a domain controller." -ForegroundColor Red
    }
}

# Function to update time from Microsoft's time servers
function Update-TimeFromMicrosoft {
    Write-Host "Updating time from Microsoft's time servers..."

    # Update time from Microsoft time servers
    w32tm /config /manualpeerlist:"time.windows.com,0x9" /syncfromflags:manual /reliable:YES /update
    w32tm /resync
    Write-Host "Time updated from Microsoft's time servers."
}

# Main script execution
if (Is-DomainController) {
    Write-Host "This machine is a domain controller."
    Update-TimeFromMicrosoft
} else {
    Write-Host "This machine is not a domain controller."
    Sync-TimeWithDomainController
}

Write-Host "Script execution completed."
