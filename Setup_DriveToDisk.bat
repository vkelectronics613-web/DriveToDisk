@echo off
setlocal EnableDelayedExpansion
title DriveToDisk - 1-Click Cloud Hard Drive Setup
color 0b

echo ===============================================================
echo            DriveToDisk (Free ^& Open Source)
echo    Mount Your Google Drive as a Physical Windows Drive!
echo ===============================================================
echo.

:: 1. Check Winget
where winget >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] 'winget' is required. Please update Windows or install App Installer.
    pause
    exit /b 1
)

:: 2. Install WinFsp
echo [*] Checking Windows FUSE Driver (WinFsp)...
winget list --id WinFsp.WinFsp >nul 2>nul
if %errorlevel% neq 0 (
    echo [*] Installing WinFsp driver...
    winget install --id WinFsp.WinFsp -e --accept-source-agreements --accept-package-agreements --silent
) else (
    echo [OK] WinFsp driver already installed.
)

:: 3. Install Rclone
echo [*] Checking Rclone Engine...
where rclone >nul 2>nul
if %errorlevel% neq 0 (
    echo [*] Installing Rclone...
    winget install --id Rclone.Rclone -e --accept-source-agreements --accept-package-agreements --silent
    set "PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Microsoft\WinGet\Links"
) else (
    echo [OK] Rclone already installed.
)

:: 4. Ask User for Drive Letter
set "TARGET_DRIVE=E"
echo.
set /p "USER_DRIVE=Choose drive letter for your Cloud Drive [Default: E]: "
if not "!USER_DRIVE!"=="" set "TARGET_DRIVE=!USER_DRIVE!"
set "TARGET_DRIVE=!TARGET_DRIVE:~0,1!"
echo [*] Selected Drive: !TARGET_DRIVE!:

:: 5. Authenticate with Google Drive
echo.
echo ===============================================================
echo   ACTION REQUIRED:
echo   Your browser will now open to authorize Google Drive.
echo   Log in and click "Allow" to grant access to your storage.
echo ===============================================================
echo.
rclone config create gdrive drive scope drive

if %errorlevel% neq 0 (
    echo [!] Authorization cancelled or failed.
    pause
    exit /b 1
)

:: 6. Setup Local Config Directory
set "APP_DIR=%USERPROFILE%\.drivetodisk"
if not exist "!APP_DIR!" mkdir "!APP_DIR!"
if not exist "!APP_DIR!\cache" mkdir "!APP_DIR!\cache"

:: 7. Create Background Mount Script
(
echo @echo off
echo rclone mount gdrive: !TARGET_DRIVE!: --vfs-cache-mode full --vfs-cache-max-size 30G --cache-dir "!APP_DIR!\cache" --volname "Google Cloud Drive" --drive-chunk-size 64M
) > "!APP_DIR!\mount_engine.bat"

:: 8. Create Silent Launcher
(
echo Set WshShell = CreateObject("WScript.Shell"^)
echo WshShell.Run "cmd /c ""!APP_DIR!\mount_engine.bat""", 0, False
) > "!APP_DIR!\mount_silent.vbs"

:: 9. Add to Windows Startup (Auto-mount on Boot)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "DriveToDisk" /t REG_SZ /d "!APP_DIR!\mount_silent.vbs" /f >nul

:: 10. Launch Immediately
echo.
echo [*] Starting Cloud Drive (!TARGET_DRIVE!:)...
wscript "!APP_DIR!\mount_silent.vbs"

echo.
echo ===============================================================
echo   SUCCESS! Your Cloud Drive is now active on !TARGET_DRIVE!:
echo   - Total space matches your real Google Drive quota!
echo   - It will auto-mount every time Windows starts.
echo ===============================================================
echo.
pause
