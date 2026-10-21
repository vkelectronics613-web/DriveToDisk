@echo off
title DriveToDisk - Disconnect & Uninstall
echo ===============================================================
echo            DriveToDisk - Uninstaller
echo ===============================================================
echo.

taskkill /f /im rclone.exe >nul 2>nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "DriveToDisk" /f >nul 2>nul
rmdir /s /q "%USERPROFILE%\.drivetodisk" >nul 2>nul

echo [OK] Cloud Drive unmounted.
echo [OK] Startup auto-mount removed.
echo [OK] Cache cleaned up.
echo.
echo DriveToDisk has been removed successfully.
pause
