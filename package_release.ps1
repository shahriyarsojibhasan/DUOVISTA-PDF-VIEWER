# Package script for DuoVista PDF Studio Release
# Created by Shahriyar Sojib Hasan

$ErrorActionPreference = "Stop"

$releaseDir = "release"
if (-not (Test-Path $releaseDir)) {
    New-Item -ItemType Directory -Path $releaseDir | Out-Null
}

$zipName = "$releaseDir\DuoVista-PDF-Studio-v2.1.0-Chrome-Edge-Store.zip"
if (Test-Path $zipName) {
    Remove-Item $zipName -Force
}

Write-Host "Creating clean release ZIP package for Chrome Web Store & Edge Add-ons..." -ForegroundColor Cyan

# Files and folders to include
$includeItems = @(
    "manifest.json",
    "background.js",
    "viewer.html",
    "viewer.css",
    "viewer.js",
    "privacy.html",
    "terms.html",
    "index.html",
    "llms.txt",
    "robots.txt",
    "sitemap.xml",
    "README.md",
    "icons",
    "lib",
    "sample"
)

# Use .NET System.IO.Compression.ZipFile to create zip
Add-Type -AssemblyName System.IO.Compression.FileSystem
$tempFolder = "$env:TEMP\duovista_build_$([System.Guid]::NewGuid().ToString())"
New-Item -ItemType Directory -Path $tempFolder | Out-Null

try {
    foreach ($item in $includeItems) {
        if (Test-Path $item) {
            Copy-Item -Path $item -Destination $tempFolder -Recurse -Force
        }
    }
    [System.IO.Compression.ZipFile]::CreateFromDirectory($tempFolder, $zipName)
    Write-Host "Successfully packaged: $zipName" -ForegroundColor Green
} finally {
    Remove-Item -Path $tempFolder -Recurse -Force -ErrorAction SilentlyContinue
}

$zipSize = (Get-Item $zipName).Length / 1MB
Write-Host ("Release Package Size: {0:N2} MB" -f $zipSize) -ForegroundColor Yellow
Write-Host "Ready for Chrome Web Store & Microsoft Edge Partner Center publication!" -ForegroundColor Green
