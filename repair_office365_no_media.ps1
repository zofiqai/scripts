# zofiq.ai
# This script will repair Microsoft Office 365 using the OfficeC2RClient.exe utility

# Define the path to the OfficeC2RClient.exe
$OfficeC2RClientPath = "$env:ProgramFiles\Microsoft Office\Office16\OfficeC2RClient.exe"

# Check if OfficeC2RClient.exe exists
if (Test-Path $OfficeC2RClientPath) {
    try {
        # Start the repair process
        Write-Output "Starting repair process for Microsoft Office 365..."
        Start-Process -FilePath $OfficeC2RClientPath -ArgumentList "/update user" -NoNewWindow -Wait

        # Check the exit code
        if ($LASTEXITCODE -eq 0) {
            Write-Output "Microsoft Office 365 repair process completed successfully."
        } else {
            Write-Output "Microsoft Office 365 repair process completed with errors. Exit code: $LASTEXITCODE"
        }
    } catch {
        Write-Output "An error occurred while trying to repair Microsoft Office 365: $_"
    }
} else {
    Write-Output "OfficeC2RClient.exe not found. Please ensure Microsoft Office 365 is installed on this machine."
}
