# Read environment variables from .env file
$envContent = Get-Content .env
$configDir = "./config"  # Default value
$mediaDir = "../"       # Default value
$tempDir = "./temp"     # Default value

# Parse .env file for custom paths
foreach ($line in $envContent) {
    if ($line -match "CONFIG_DIR=(.*)") {
        $configDir = $matches[1].Trim()
    }
    if ($line -match "MEDIA_DIR=(.*)") {
        $mediaDir = $matches[1].Trim()
    }
    if ($line -match "TEMP_DIR=(.*)") {
        $tempDir = $matches[1].Trim()
    }
}

# Convert potential Windows-style paths to proper format
$configDir = $configDir.Replace('\', '/')
$mediaDir = $mediaDir.Replace('\', '/')
$tempDir = $tempDir.Replace('\', '/')

# Create config directories
$configDirs = @(
    "$configDir",
    "$configDir/radarr",
    "$configDir/sonarr",
    "$configDir/plex",
    "$configDir/plexTranscode",
    "$configDir/transmission",
    "$configDir/transmissionWatch",
    "$configDir/nzbget",
    "$configDir/nginx",
    "$configDir/overseerr",
    "$configDir/prowlarr",
    "$configDir/qbittorent",
    "$configDir/openvpn",
    "$configDir/mdblistarr/db"
)

# Create media directories
$mediaDirs = @(
    "$mediaDir",
    "$mediaDir/downloads",
    "$mediaDir/movies",
    "$mediaDir/tv",
    "$mediaDir/music",
    "$mediaDir/import"
)

# Create temp directories
$tempDirs = @(
    "$tempDir",
    "$tempDir/plex/transcode",
    "$tempDir/transmission/watch",
    "$tempDir/qbittorrent/temp"
)

Write-Host "Creating directory structure..."
Write-Host "Config directory: $configDir"
Write-Host "Media directory: $mediaDir"
Write-Host "Temp directory: $tempDir"
Write-Host ""

# Create config directories
foreach ($dir in $configDirs) {
    if (-not (Test-Path $dir)) {
        Write-Host "Creating directory: $dir"
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    } else {
        Write-Host "Directory already exists: $dir"
    }
}

# Create media directories
foreach ($dir in $mediaDirs) {
    if (-not (Test-Path $dir)) {
        Write-Host "Creating directory: $dir"
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    } else {
        Write-Host "Directory already exists: $dir"
    }
}

# Create temp directories
foreach ($dir in $tempDirs) {
    if (-not (Test-Path $dir)) {
        Write-Host "Creating directory: $dir"
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    } else {
        Write-Host "Directory already exists: $dir"
    }
}

Write-Host ""
Write-Host "Directory structure created successfully!"
Write-Host "You can now run 'docker-compose up -d' to start your services." 