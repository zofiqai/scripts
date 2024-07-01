#C reated by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# The script uses the Shell.Application COM object to access and empty the Recycle Bin.
# It is designed to work on all versions of Windows back to Windows 8, including Server-based operating systems.

# Function to empty the Recycle Bin
function Empty-RecycleBin {
    Write-Host "Emptying the Recycle Bin..."

    # Create a new Shell object
    $shell = New-Object -ComObject Shell.Application

    # Access the Recycle Bin folder
    $recycleBin = $shell.Namespace(0xA)

    if ($recycleBin) {
        $recycleBin.Items() | ForEach-Object { $_.InvokeVerb("delete") }
        Write-Host "Recycle Bin has been successfully emptied."
    } else {
        Write-Host "Failed to access the Recycle Bin." -ForegroundColor Red
    }
}

# Execute the function
Empty-RecycleBin

Write-Host "Script execution completed."
