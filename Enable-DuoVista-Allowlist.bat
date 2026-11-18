@echo off
chcp 65001 >nul
title DuoVista PDF Studio - Windows 10/11 Browser Security Fix & Auto-Setup
color 0b

set "IS_ADMIN=0"
net session >nul 2>&1
if %errorLevel% equ 0 set "IS_ADMIN=1"

if "%1"=="USERONLY" goto :RUN_ALLOWLIST
if "%IS_ADMIN%"=="0" (
    echo Requesting Administrator privileges for Windows 10/11 Chrome ^& Edge Policy...
    powershell -NoProfile -Command "try { Start-Process -FilePath '%~f0' -Verb RunAs } catch { Start-Process -FilePath '%~f0' -ArgumentList 'USERONLY' }"
    exit /b
)

:RUN_ALLOWLIST
cd /d "%~dp0"

echo =========================================================================
echo       DuoVista PDF Studio - Windows 10 ^& 11 Browser Security Fix
echo       Created by Shahriyar Sojib Hasan (Free for Students Worldwide)
echo       Support: https://buymeacoffee.com/shahriyarsojibhasan
echo =========================================================================
echo.
echo [1/3] Unlocking Extension ID (nddnddpjpbnkkbekjdflejaefbeniloa) in
echo       Windows 10/11 Registry for Chrome, Edge ^& Brave...
echo.

:: User (HKCU) Policies (Always works)
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

if "%IS_ADMIN%"=="1" (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1

    reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
    echo   [OK] Chrome, Edge ^& Brave policies (HKLM + HKCU) updated.
) else (
    echo   [OK] Chrome, Edge ^& Brave user policies (HKCU) updated.
)

if "%IS_ADMIN%"=="1" (
    set "INSTALL_DIR=C:\DuoVista-PDF-Studio"
) else (
    set "INSTALL_DIR=%LOCALAPPDATA%\DuoVista-PDF-Studio"
)

if exist "%~dp0manifest.json" (
    if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
    for %%F in (manifest.json background.js viewer.html viewer.css viewer.js index.html privacy.html terms.html manifest.webmanifest) do (
        if exist "%~dp0%%F" copy /Y "%~dp0%%F" "%INSTALL_DIR%\" >nul 2>&1
    )
    xcopy "%~dp0icons" "%INSTALL_DIR%\icons\" /E /I /Y /Q >nul 2>&1
    xcopy "%~dp0lib" "%INSTALL_DIR%\lib\" /E /I /Y /Q >nul 2>&1
    xcopy "%~dp0sample" "%INSTALL_DIR%\sample\" /E /I /Y /Q >nul 2>&1
) else if exist "%~dp0DuoVista-PDF-Studio-v2.1.0.crx" (
    if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%" >nul 2>&1
    set "CRX_FILE=%~dp0DuoVista-PDF-Studio-v2.1.0.crx"
    set "OUT_DIR=%INSTALL_DIR%"
    powershell -NoProfile -Command "$b=[IO.File]::ReadAllBytes($env:CRX_FILE);$i=12;while($i -lt $b.Length-4){if($b[$i]-eq 80 -and $b[$i+1]-eq 75 -and $b[$i+2]-eq 3 -and $b[$i+3]-eq 4){break};$i++};$z=Join-Path $env:TEMP 'duovista_unpack.zip';[IO.File]::WriteAllBytes($z,$b[$i..($b.Length-1)]);Expand-Archive -LiteralPath $z -DestinationPath $env:OUT_DIR -Force;Remove-Item -LiteralPath $z -Force" >nul 2>&1
)
<nul set /p="%INSTALL_DIR%" | clip

echo.
echo [2/3] Permanent Folder Ready at: %INSTALL_DIR% (Copied to Clipboard!)
echo.
echo [3/3] How to Enable if Toggle Switch was Greyed Out on Windows 10/11:
echo   1. Open chrome://extensions or edge://extensions
echo   2. Remove the old greyed-out CRX card if present.
echo   3. Turn ON "Developer mode" switch.
echo   4. Click "Load unpacked" -> Press Ctrl+V -> Select Folder!
echo      (Or drag and drop the FOLDER "%INSTALL_DIR%" onto the page!)
echo   -> The switch will be 100%% ON and active forever!
echo.
echo =========================================================================
echo All set! Press any key to exit.
echo =========================================================================
pause >nul
