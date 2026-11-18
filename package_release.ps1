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

# Pure Web / Store Extension items (No .bat / .reg binaries that Store reviewers flag)
$storeItems = @(
    "manifest.json",
    "manifest.webmanifest",
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
    "updates.xml",
    "google6630922b71338df7.html",
    "README.md",
    "icons",
    "lib",
    "sample"
)

# Helper scripts included in Unpacked.zip & CRX.zip for Windows 10/11 users
$helperItems = @(
    "HOW_TO_INSTALL.txt",
    "Fix-Windows-10-11-Extension.bat",
    "1-Click-Install-Edge.bat",
    "Enable-DuoVista-Allowlist.bat",
    "Enable-DuoVista-Allowlist.reg"
)

Add-Type -AssemblyName System.IO.Compression.FileSystem

# 1. Create Clean Build Folder for Store & CRX Packing
$cleanBuildDir = "$env:TEMP\DuoVista-PDF-Studio"
if (Test-Path $cleanBuildDir) { Remove-Item $cleanBuildDir -Recurse -Force }
New-Item -ItemType Directory -Path $cleanBuildDir | Out-Null

foreach ($item in $storeItems) {
    $srcPath = Join-Path $workspaceDir $item
    if (Test-Path $srcPath) {
        Copy-Item -Path $srcPath -Destination $cleanBuildDir -Recurse -Force
    }
}

# 2. Create Store Zip (pure extension package for Chrome Web Store & Edge Add-ons)
if (Test-Path $storeZipName) { Remove-Item $storeZipName -Force }
[System.IO.Compression.ZipFile]::CreateFromDirectory($cleanBuildDir, $storeZipName)
Write-Host "[OK] Store package created: $storeZipName" -ForegroundColor Green

# 3. Create Unpacked Zip (contains DuoVista-PDF-Studio folder + Windows 10/11 helpers)
if (Test-Path $unpackedZipName) { Remove-Item $unpackedZipName -Force }
$tempRoot = "$env:TEMP\duovista_unpacked_container_$([System.Guid]::NewGuid().ToString())"
$tempSub = Join-Path $tempRoot "DuoVista-PDF-Studio"
Copy-Item -Path $cleanBuildDir -Destination $tempSub -Recurse -Force
foreach ($h in $helperItems) {
    $hp = Join-Path $workspaceDir $h
    if (Test-Path $hp) {
        Copy-Item -Path $hp -Destination $tempSub -Force
    }
}
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

# 5. Create CRX Bundle ZIP (Contains CRX + Install helpers + Guide)
$crxZipName = Join-Path $releaseDir "DuoVista-PDF-Studio-v2.1.0-CRX.zip"
if (Test-Path $crxZipName) { Remove-Item $crxZipName -Force }
$tempCrxBundle = "$env:TEMP\duovista_crx_bundle_$([System.Guid]::NewGuid().ToString())"
New-Item -ItemType Directory -Path $tempCrxBundle | Out-Null
try {
    if (Test-Path $crxName) {
        Copy-Item -Path $crxName -Destination $tempCrxBundle -Force
    }
    Copy-Item -Path (Join-Path $workspaceDir "Fix-Windows-10-11-Extension.bat") -Destination $tempCrxBundle -Force
    Copy-Item -Path (Join-Path $workspaceDir "1-Click-Install-Edge.bat") -Destination $tempCrxBundle -Force
    Copy-Item -Path (Join-Path $workspaceDir "Enable-DuoVista-Allowlist.bat") -Destination $tempCrxBundle -Force
    Copy-Item -Path (Join-Path $workspaceDir "Enable-DuoVista-Allowlist.reg") -Destination $tempCrxBundle -Force
    Copy-Item -Path (Join-Path $workspaceDir "HOW_TO_INSTALL.txt") -Destination $tempCrxBundle -Force
    [System.IO.Compression.ZipFile]::CreateFromDirectory($tempCrxBundle, $crxZipName)
    Write-Host "[OK] CRX Bundle ZIP created: $crxZipName" -ForegroundColor Green
} finally {
    Remove-Item -Path $tempCrxBundle -Recurse -Force -ErrorAction SilentlyContinue
}

# Also copy CRX.zip to workspace root for instant access
Copy-Item -Path $crxZipName -Destination (Join-Path $workspaceDir "DuoVista-PDF-Studio-v2.1.0-CRX.zip") -Force

# Copy scripts to release folder for direct download
Copy-Item -Path (Join-Path $workspaceDir "Fix-Windows-10-11-Extension.bat") -Destination $releaseDir -Force
Copy-Item -Path (Join-Path $workspaceDir "1-Click-Install-Edge.bat") -Destination $releaseDir -Force
Copy-Item -Path (Join-Path $workspaceDir "Enable-DuoVista-Allowlist.bat") -Destination $releaseDir -Force
Copy-Item -Path (Join-Path $workspaceDir "Enable-DuoVista-Allowlist.reg") -Destination $releaseDir -Force

Write-Host "All release packages ready in: $releaseDir" -ForegroundColor Yellow
Get-ChildItem -Path $releaseDir | Select-Object Name, Length, LastWriteTime
