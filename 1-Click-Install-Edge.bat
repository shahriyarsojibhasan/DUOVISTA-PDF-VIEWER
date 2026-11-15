@echo off
chcp 65001 >nul
title DuoVista PDF Studio - Edge & Chrome Setup Assistant
color 0b

echo =========================================================================
echo       DuoVista PDF Studio - Microsoft Edge Installation Helper
echo       Created by Shahriyar Sojib Hasan (100%% Free for Students)
echo       Support: https://buymeacoffee.com/shahriyarsojibhasan
echo =========================================================================
echo.
echo [1/3] Applying Windows Registry Policy for Microsoft Edge & Google Chrome...

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
echo [2/3] Copying extension folder path to clipboard...
echo %~dp0| set /p= | clip
echo   [OK] Folder path copied to clipboard: %~dp0
echo.
echo [3/3] Opening Microsoft Edge Extensions page...
start "" "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "edge://extensions"

echo.
echo =========================================================================
echo                 ★ EDGE INSTALLATION INSTRUCTIONS (5 SECONDS) ★
echo =========================================================================
echo  1. In the Edge window that just opened:
echo     Look at the BOTTOM-LEFT sidebar and turn ON "Developer mode".
echo.
echo  2. Click the "Load unpacked" button at the TOP of the page.
echo.
echo  3. In the folder picker window, press Ctrl+V (path is already copied)
echo     or select this folder:
echo     "%~dp0"
echo.
echo  4. Click "Select Folder".
echo.
echo  DONE! DuoVista PDF Studio is now permanently installed in Edge!
echo =========================================================================
echo.
pause
