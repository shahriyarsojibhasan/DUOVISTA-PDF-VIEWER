# Package script for DuoVista PDF Studio Release
# Created by Shahriyar Sojib Hasan
# Support: https://buymeacoffee.com/shahriyarsojibhasan

$ErrorActionPreference = "Stop"

$workspaceDir = $PSScriptRoot
if (-not $workspaceDir) { $workspaceDir = (Get-Location).Path }
$releaseDir = Join-Path $workspaceDir "release"

if (-not (Test-Path $releaseDir)) {
    New-Item -ItemType Directory -Path $releaseDir | Out-Null
}

$storeZipName = Join-Path $releaseDir "DuoVista-PDF-Studio-v2.1.0-Chrome-Edge-Store.zip"
$unpackedZipName = Join-Path $releaseDir "DuoVista-PDF-Studio-v2.1.0-Unpacked.zip"
$crxName = Join-Path $releaseDir "DuoVista-PDF-Studio-v2.1.0.crx"
$pemKey = Join-Path $releaseDir "DuoVista-PDF-Studio-key.pem"

Write-Host "Creating clean release packages for DuoVista PDF Studio..." -ForegroundColor Cyan

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
    "1-Click-Install-Edge.bat",
    "Enable-DuoVista-Allowlist.bat",
    "Enable-DuoVista-Allowlist.reg",
    "icons",
    "lib",
    "sample"
)

Add-Type -AssemblyName System.IO.Compression.FileSystem

# 1. Create Clean Build Folder for Store & Packing
$cleanBuildDir = "$env:TEMP\DuoVista-PDF-Studio"
if (Test-Path $cleanBuildDir) { Remove-Item $cleanBuildDir -Recurse -Force }
New-Item -ItemType Directory -Path $cleanBuildDir | Out-Null

foreach ($item in $includeItems) {
    $srcPath = Join-Path $workspaceDir $item
    if (Test-Path $srcPath) {
        Copy-Item -Path $srcPath -Destination $cleanBuildDir -Recurse -Force
    }
}

# 2. Create Store Zip (no parent directory inside zip)
if (Test-Path $storeZipName) { Remove-Item $storeZipName -Force }
[System.IO.Compression.ZipFile]::CreateFromDirectory($cleanBuildDir, $storeZipName)
Write-Host "[OK] Store package created: $storeZipName" -ForegroundColor Green

# 3. Create Unpacked Zip (contains DuoVista-PDF-Studio root folder for clean Extract All)
if (Test-Path $unpackedZipName) { Remove-Item $unpackedZipName -Force }
$tempRoot = "$env:TEMP\duovista_unpacked_container_$([System.Guid]::NewGuid().ToString())"
$tempSub = Join-Path $tempRoot "DuoVista-PDF-Studio"
Copy-Item -Path $cleanBuildDir -Destination $tempSub -Recurse -Force
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempRoot, $unpackedZipName)
Remove-Item -Path $tempRoot -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "[OK] Unpacked package created: $unpackedZipName" -ForegroundColor Green

# 4. Pack clean .CRX using Chrome / Edge
$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$packerPath = $null

if (Test-Path $chromePath) {
    $packerPath = $chromePath
} elseif (Test-Path $edgePath) {
    $packerPath = $edgePath
}

if ($packerPath -and (Test-Path $pemKey)) {
    Write-Host "Packing clean CRX from staging directory..." -ForegroundColor Cyan
    $expectedCrx = "$env:TEMP\DuoVista-PDF-Studio.crx"
    if (Test-Path $expectedCrx) { Remove-Item $expectedCrx -Force }
    
    # Run packing command on the clean staging dir
    & $packerPath --pack-extension="$cleanBuildDir" --pack-extension-key="$pemKey" | Out-Null
    Start-Sleep -Seconds 2
    
    if (Test-Path $expectedCrx) {
        Move-Item -Path $expectedCrx -Destination $crxName -Force
        Write-Host "[OK] Clean CRX generated: $crxName" -ForegroundColor Green
    }
}

# Clean staging build folder
Remove-Item -Path $cleanBuildDir -Recurse -Force -ErrorAction SilentlyContinue

# Copy scripts to release folder for direct download
Copy-Item -Path (Join-Path $workspaceDir "1-Click-Install-Edge.bat") -Destination $releaseDir -Force
Copy-Item -Path (Join-Path $workspaceDir "Enable-DuoVista-Allowlist.bat") -Destination $releaseDir -Force
Copy-Item -Path (Join-Path $workspaceDir "Enable-DuoVista-Allowlist.reg") -Destination $releaseDir -Force

Write-Host "All release packages ready in: $releaseDir" -ForegroundColor Yellow
Get-ChildItem -Path $releaseDir | Select-Object Name, Length, LastWriteTime
