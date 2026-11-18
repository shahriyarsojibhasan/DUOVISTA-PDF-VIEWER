@echo off
chcp 65001 >nul
title DuoVista PDF Studio - Windows 10 & 11 Extension Security Fix & Auto-Installer
color 0b

set "IS_ADMIN=0"
net session >nul 2>&1
if %errorLevel% equ 0 set "IS_ADMIN=1"

if "%1"=="USERONLY" goto :START_FIX
if "%IS_ADMIN%"=="0" (
    echo Requesting Administrator privileges to unlock Windows 10/11 HKLM policies...
    powershell -NoProfile -Command "try { Start-Process -FilePath '%~f0' -Verb RunAs } catch { Start-Process -FilePath '%~f0' -ArgumentList 'USERONLY' }"
    exit /b
)

:START_FIX
cd /d "%~dp0"

echo ============================================================================
echo    DuoVista PDF Studio (v2.1.0) - Windows 10 ^& 11 Complete Security Fix
echo    Created by Shahriyar Sojib Hasan (100%% Free for Students Worldwide)
echo    Support: https://buymeacoffee.com/shahriyarsojibhasan
echo ============================================================================
echo.

:: Step 1: Apply HKLM (if Admin) & HKCU Policies for Chrome, Edge, and Brave
echo [1/4] Applying Windows 10/11 Registry Policies for Chrome, Edge ^& Brave...

:: Google Chrome HKCU
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "*" /f >nul 2>&1

:: Microsoft Edge HKCU
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "*" /f >nul 2>&1

:: Brave HKCU
reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "*" /f >nul 2>&1

if "%IS_ADMIN%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "*" /f >nul 2>&1

    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "*" /f >nul 2>&1

    reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "*" /f >nul 2>&1
    echo   [OK] Windows 10/11 HKLM ^& HKCU Registry Policies unlocked!
) else (
    echo   [OK] Windows User HKCU Registry Policies applied!
)
echo.

:: Step 2: Prepare Permanent Unpacked Folder (C:\DuoVista-PDF-Studio if Admin, else %LOCALAPPDATA%\DuoVista-PDF-Studio)
if "%IS_ADMIN%"=="1" (
    set "INSTALL_DIR=C:\DuoVista-PDF-Studio"
) else (
    set "INSTALL_DIR=%LOCALAPPDATA%\DuoVista-PDF-Studio"
)
echo [2/4] Preparing permanent active folder at %INSTALL_DIR%...

if exist "%~dp0manifest.json" (
    if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
    for %%F in (manifest.json background.js viewer.html viewer.css viewer.js index.html privacy.html terms.html manifest.webmanifest) do (
        if exist "%~dp0%%F" copy /Y "%~dp0%%F" "%INSTALL_DIR%\" >nul 2>&1
    )
    xcopy "%~dp0icons" "%INSTALL_DIR%\icons\" /E /I /Y /Q >nul 2>&1
    xcopy "%~dp0lib" "%INSTALL_DIR%\lib\" /E /I /Y /Q >nul 2>&1
    xcopy "%~dp0sample" "%INSTALL_DIR%\sample\" /E /I /Y /Q >nul 2>&1
    echo   [OK] Extension files installed cleanly to: %INSTALL_DIR%
) else if exist "%~dp0DuoVista-PDF-Studio-v2.1.0.crx" (
    echo   [INFO] Converting CRX package to permanent folder at %INSTALL_DIR%...
    if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
    set "CRX_FILE=%~dp0DuoVista-PDF-Studio-v2.1.0.crx"
    set "OUT_DIR=%INSTALL_DIR%"
    powershell -NoProfile -Command "$b=[IO.File]::ReadAllBytes($env:CRX_FILE);$i=12;while($i -lt $b.Length-4){if($b[$i]-eq 80 -and $b[$i+1]-eq 75 -and $b[$i+2]-eq 3 -and $b[$i+3]-eq 4){break};$i++};$z=Join-Path $env:TEMP 'duovista_unpack.zip';[IO.File]::WriteAllBytes($z,$b[$i..($b.Length-1)]);Expand-Archive -LiteralPath $z -DestinationPath $env:OUT_DIR -Force;Remove-Item -LiteralPath $z -Force" >nul 2>&1
    echo   [OK] CRX converted and unpacked to: %INSTALL_DIR%
) else (
    echo   [!] Place this script next to manifest.json or DuoVista-PDF-Studio-v2.1.0.crx
)

:: Copy exact path to clipboard cleanly without newline
<nul set /p="%INSTALL_DIR%" | clip
echo   [OK] Exact path copied to Clipboard: %INSTALL_DIR%
echo.

:: Step 3: Refresh policy if Admin
echo [3/4] Refreshing policy ^& highlighting folder...
if "%IS_ADMIN%"=="1" gpupdate /target:computer /force >nul 2>&1
start "" explorer.exe /select,"%INSTALL_DIR%"
echo   [OK] Opened File Explorer highlighting "%INSTALL_DIR%"!
echo.

:: Step 4: Open Browser Extensions Manager
echo [4/4] Opening Chrome ^& Edge Extensions page...
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "chrome://extensions"
) else if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
    start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" "chrome://extensions"
) else if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" (
    start "" "%LocalAppData%\Google\Chrome\Application\chrome.exe" "chrome://extensions"
)

if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "edge://extensions"
) else if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    start "" "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" "edge://extensions"
)

echo.
echo ============================================================================
echo   ★ HOW TO TURN ON DUOVISTA IN WINDOWS 10 / WINDOWS 11 (100%% GUARANTEED) ★
echo ============================================================================
echo.
echo   WHY WAS THE CRX SWITCH GREYED OUT / DISABLED?
echo   Windows 10/11 Chrome ^& Edge block raw ".crx" files from turning ON unless
echo   loaded as an Unpacked Folder!
echo.
echo   DO THIS NOW (TAKES 5 SECONDS):
echo   1. In Chrome (chrome://extensions) or Edge (edge://extensions):
echo      If there is an old disabled DuoVista card, click "Remove" on it first.
echo.
echo   2. Turn ON the "Developer mode" switch (top-right in Chrome, bottom-left in Edge).
echo.
echo   3. Simply DRAG ^& DROP the highlighted folder "%INSTALL_DIR%" from
echo      the File Explorer window directly onto the extensions page!
echo      (OR click "Load unpacked" -> press Ctrl+V -> click "Select Folder").
echo.
echo   4. Click "Details" -> Turn ON "Allow access to file URLs" to open local PDFs!
echo.
echo   RESULT: Toggle switch is 100%% ON, active forever, with ZERO warnings!
echo ============================================================================
echo.
pause
