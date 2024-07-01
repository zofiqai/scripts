# Created by zofiQ
# Always test in a non-production environment prior to deploying to a live system that is in production!

# The script checks for the installation of Microsoft Edge, Google Chrome, Firefox, Opera, Brave, and Chromium.
# It then clears the temporary internet files for each detected browser.

# Function to clear temporary files for Microsoft Edge
function Clear-EdgeCache {
    Write-Host "Clearing Microsoft Edge cache..."
    $edgeCachePath = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"
    if (Test-Path $edgeCachePath) {
        Remove-Item "$edgeCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Microsoft Edge cache cleared."
    } else {
        Write-Host "Microsoft Edge cache path not found." -ForegroundColor Yellow
    }
}

# Function to clear temporary files for Google Chrome
function Clear-ChromeCache {
    Write-Host "Clearing Google Chrome cache..."
    $chromeCachePath = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"
    if (Test-Path $chromeCachePath) {
        Remove-Item "$chromeCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Google Chrome cache cleared."
    } else {
        Write-Host "Google Chrome cache path not found." -ForegroundColor Yellow
    }
}

# Function to clear temporary files for Firefox
function Clear-FirefoxCache {
    Write-Host "Clearing Firefox cache..."
    $firefoxCachePath = "$env:APPDATA\Mozilla\Firefox\Profiles"
    if (Test-Path $firefoxCachePath) {
        Get-ChildItem -Path $firefoxCachePath -Directory | ForEach-Object {
            $cachePath = "$($_.FullName)\cache2"
            if (Test-Path $cachePath) {
                Remove-Item "$cachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
                Write-Host "Firefox cache cleared for profile $($_.Name)."
            }
        }
    } else {
        Write-Host "Firefox cache path not found." -ForegroundColor Yellow
    }
}

# Function to clear temporary files for Opera
function Clear-OperaCache {
    Write-Host "Clearing Opera cache..."
    $operaCachePath = "$env:APPDATA\Opera Software\Opera Stable\Cache"
    if (Test-Path $operaCachePath) {
        Remove-Item "$operaCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Opera cache cleared."
    } else {
        Write-Host "Opera cache path not found." -ForegroundColor Yellow
    }
}

# Function to clear temporary files for Brave
function Clear-BraveCache {
    Write-Host "Clearing Brave cache..."
    $braveCachePath = "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\User Data\Default\Cache"
    if (Test-Path $braveCachePath) {
        Remove-Item "$braveCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Brave cache cleared."
    } else {
        Write-Host "Brave cache path not found." -ForegroundColor Yellow
    }
}

# Function to clear temporary files for Chromium
function Clear-ChromiumCache {
    Write-Host "Clearing Chromium cache..."
    $chromiumCachePath = "$env:LOCALAPPDATA\Chromium\User Data\Default\Cache"
    if (Test-Path $chromiumCachePath) {
        Remove-Item "$chromiumCachePath\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Chromium cache cleared."
    } else {
        Write-Host "Chromium cache path not found." -ForegroundColor Yellow
    }
}

# Main script execution
Write-Host "Detecting installed browsers and clearing cache..."

Clear-EdgeCache
Clear-ChromeCache
Clear-FirefoxCache
Clear-OperaCache
Clear-BraveCache
Clear-ChromiumCache

Write-Host "Script execution completed."
