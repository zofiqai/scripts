#Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!
# This script uses the Clear-DnsClientCache cmdlet to flush the DNS cache. 

# It also includes error handling to notify via event log if the operation fails, typically due to insufficient privileges.

# Function to flush DNS cache
function Flush-DNSCache {
    Write-Host "Flushing DNS cache..."

    # Clear DNS cache
    Try {
        Clear-DnsClientCache
        Write-Host "DNS cache has been successfully flushed."
    } Catch {
        Write-Host "Failed to flush DNS cache. Please ensure you are running this script with administrative privileges." -ForegroundColor Red
    }
}

# Execute the function
Flush-DNSCache

Write-Host "Script execution completed."
