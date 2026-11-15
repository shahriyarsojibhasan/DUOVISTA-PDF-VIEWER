@echo off
chcp 65001 >nul
title DuoVista PDF Studio - 1-Click Browser Fix for Chrome & Edge
color 0b

echo =========================================================================
echo       DuoVista PDF Studio - Official Windows Fix & Setup Tool
echo       Created by Shahriyar Sojib Hasan (Free for Students Worldwide)
echo       Support: https://buymeacoffee.com/shahriyarsojibhasan
echo =========================================================================
echo.
echo [1/3] Adding DuoVista Extension ID (nddnddpjpbnkkbekjdflejaefbeniloa)
echo       to Google Chrome, Microsoft Edge, and Brave Allowlist...
echo.

:: Add Allowlist for Google Chrome
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Google Chrome policy updated successfully.
) else (
    echo   [!] Could not update Chrome policy.
)

:: Add Allowlist for Microsoft Edge
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Microsoft Edge policy updated successfully.
) else (
    echo   [!] Could not update Edge policy.
)

:: Add Allowlist for Brave
reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Brave Browser policy updated successfully.
) else (
    echo   [!] Could not update Brave policy.
)

echo.
echo [2/3] Registry Fix Applied!
echo.
echo   * Edge fix: 'CRX_REQUIRED_PROOF_MISSING' error is now resolved!
echo   * Chrome fix: 'This extension is not listed in Chrome Web Store'
echo     disabling block is now bypassed!
echo.
echo [3/3] How to install:
echo   RECOMMENDED EASIEST METHOD:
echo   1. In Chrome: Open chrome://extensions -> Toggle 'Developer mode' ON -> Click 'Load unpacked' -> Select this folder!
echo   2. In Edge:   Open edge://extensions -> Toggle 'Developer mode' ON -> Click 'Load unpacked' -> Select this folder!
echo.
echo =========================================================================
echo All set! Press any key to exit.
echo =========================================================================
pause >nul
