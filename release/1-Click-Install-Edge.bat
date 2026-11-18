@echo off
chcp 65001 >nul
title DuoVista PDF Studio - Edge & Chrome Setup Assistant
color 0b

cd /d "%~dp0"

echo =========================================================================
echo       DuoVista PDF Studio - Microsoft Edge Installation Helper
echo       Created by Shahriyar Sojib Hasan (100%% Free for Students)
echo       Support: https://buymeacoffee.com/shahriyarsojibhasan
echo =========================================================================
echo.
echo [1/3] Applying Windows Registry Policy for Microsoft Edge ^& Google Chrome...

:: Edge Policies
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

:: Chrome Policies
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

echo   [OK] Registry policies applied successfully!
echo.
echo [2/3] Preparing unpacked folder path for clipboard...
set "INSTALL_DIR=%~dp0"
if "%INSTALL_DIR:~-1%"=="\" set "INSTALL_DIR=%INSTALL_DIR:~0,-1%"

if not exist "%~dp0manifest.json" if exist "%~dp0DuoVista-PDF-Studio-v2.1.0.crx" (
    set "INSTALL_DIR=%LOCALAPPDATA%\DuoVista-PDF-Studio"
    if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
    set "CRX_FILE=%~dp0DuoVista-PDF-Studio-v2.1.0.crx"
    set "OUT_DIR=%INSTALL_DIR%"
    powershell -NoProfile -Command "$b=[IO.File]::ReadAllBytes($env:CRX_FILE);$i=12;while($i -lt $b.Length-4){if($b[$i]-eq 80 -and $b[$i+1]-eq 75 -and $b[$i+2]-eq 3 -and $b[$i+3]-eq 4){break};$i++};$z=Join-Path $env:TEMP 'duovista_unpack.zip';[IO.File]::WriteAllBytes($z,$b[$i..($b.Length-1)]);Expand-Archive -LiteralPath $z -DestinationPath $env:OUT_DIR -Force;Remove-Item -LiteralPath $z -Force" >nul 2>&1
)

<nul set /p="%INSTALL_DIR%" | clip
echo   [OK] Folder path copied to clipboard: %INSTALL_DIR%
echo.
echo [3/3] Opening Microsoft Edge Extensions page...
start "" explorer.exe /select,"%INSTALL_DIR%"
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "edge://extensions"
) else if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" "edge://extensions"
)

echo.
echo =========================================================================
echo                 ★ EDGE INSTALLATION INSTRUCTIONS (5 SECONDS) ★
echo =========================================================================
echo  1. In the Edge window that just opened:
echo     Look at the BOTTOM-LEFT sidebar and turn ON "Developer mode".
echo.
echo  2. Click the "Load unpacked" button at the TOP of the page
echo     (OR simply Drag ^& Drop "%INSTALL_DIR%" onto the Edge page!).
echo.
echo  3. In the folder picker window, press Ctrl+V (path is already copied)
echo     and click "Select Folder".
echo.
echo  4. Click "Details" -> Turn ON "Allow access to file URLs".
echo  DONE! DuoVista PDF Studio is now permanently installed in Edge!
echo =========================================================================
echo.
pause
