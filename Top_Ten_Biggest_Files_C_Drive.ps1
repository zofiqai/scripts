# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# This script recursively searches the C: drive for all files and lists the top 10 biggest ones by size.

# Function to list the top 10 biggest files on the C: drive
function Get-Top10BiggestFiles {
    Write-Host "Listing the top 10 biggest files from the C: drive..."

    # Get all files from C: drive recursively and sort by size in descending order
    $biggestFiles = Get-ChildItem -Path C:\ -Recurse -File -ErrorAction SilentlyContinue |
                    Sort-Object -Property Length -Descending |
                    Select-Object -First 10

    # Output the results
    $biggestFiles | ForEach-Object {
        [PSCustomObject]@{
            Name = $_.FullName
            SizeMB = "{0:N2}" -f ($_.Length / 1MB)
        }
    } | Format-Table -AutoSize
}

# Execute the function
Get-Top10BiggestFiles

Write-Host "Script execution completed."
