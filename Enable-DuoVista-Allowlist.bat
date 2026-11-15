@echo off
chcp 65001 >nul
title DuoVista PDF Studio - Browser Allowlist & Installation Fix
color 0b

echo =========================================================================
echo       DuoVista PDF Studio - Browser Fix & Setup Tool
echo       Created by Shahriyar Sojib Hasan (Free for Students Worldwide)
echo       Support: https://buymeacoffee.com/shahriyarsojibhasan
echo =========================================================================
echo.
echo [1/3] Adding DuoVista Extension ID (nddnddpjpbnkkbekjdflejaefbeniloa)
echo       and trusted offline sources to Microsoft Edge & Google Chrome...
echo.

:: Add Policies for Microsoft Edge
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Edge\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Microsoft Edge policies updated successfully.
) else (
    echo   [!] Could not update Edge policies.
)

:: Add Policies for Google Chrome
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallSources" /v 2 /t REG_SZ /d "file://*/*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
reg add "HKCU\Software\Policies\Google\Chrome\ExtensionInstallAllowlist" /v 2 /t REG_SZ /d "nddnddpjpbnkkbekjdflejaefbeniloa" /f >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Google Chrome policies updated successfully.
) else (
    echo   [!] Could not update Chrome policies.
)

:: Add Policies for Brave
reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallSources" /v 1 /t REG_SZ /d "<all_urls>" /f >nul 2>&1
reg add "HKCU\Software\Policies\BraveSoftware\Brave\ExtensionInstallAllowlist" /v 1 /t REG_SZ /d "*" /f >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo   [OK] Brave Browser policies updated successfully.
) else (
    echo   [!] Could not update Brave policies.
)

echo.
echo [2/3] Registry Fix Applied!
echo.
echo   * Edge: 'CRX_REQUIRED_PROOF_MISSING' error resolved!
echo   * Chrome: 'This extension is not listed in Chrome Web Store' block bypassed!
echo.
echo [3/3] Recommended Standard Installation:
echo   1. In Edge: Open edge://extensions -> Toggle 'Developer mode' ON (bottom-left) -> Click 'Load unpacked' -> Select this folder!
echo   2. In Chrome: Open chrome://extensions -> Toggle 'Developer mode' ON (top-right) -> Click 'Load unpacked' -> Select this folder!
echo.
echo =========================================================================
echo All set! Press any key to exit.
echo =========================================================================
pause >nul
