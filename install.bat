@echo off
echo Vikey Inference Windows Installer
echo Author: direkturcrypto

:: Check for admin rights
net session >nul 2>&1
if %errorLevel% neq 0 (
  echo Please run as Administrator
  pause
  exit /b 1
)

:: Create installation directory
set INSTALL_DIR=C:\Program Files\Vikey Inference
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Copy binary and configuration files
if exist "vikey-inference-win.exe" (
  copy "vikey-inference-win.exe" "%INSTALL_DIR%\"
) else (
  echo Error: Binary file vikey-inference-win.exe not found!
  pause
  exit /b 1
)

:: Copy configuration files
if exist "models.json" (
  copy "models.json" "%INSTALL_DIR%\"
) else (
  echo Warning: models.json not found, creating a default one.
  echo [] > "%INSTALL_DIR%\models.json"
)

if exist ".env" (
  copy ".env" "%INSTALL_DIR%\"
) else if exist ".env.example" (
  copy ".env.example" "%INSTALL_DIR%\.env"
  echo Warning: Using .env.example as .env. Make sure to update with your API key.
) else (
  echo Warning: .env not found, creating a minimal one.
  (
    echo NODE_PORT=11434
    echo VIKEY_API_KEY=your_default_api_key_here
    echo LLAMAEDGE_ENABLED=false
    echo GAIA_CONFIG_PATH=./config
  ) > "%INSTALL_DIR%\.env"
)

:: Add to PATH
setx /M PATH "%PATH%;%INSTALL_DIR%"

:: Create shortcut
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Vikey Inference.lnk'); $Shortcut.TargetPath = '%INSTALL_DIR%\vikey-inference-win.exe'; $Shortcut.WorkingDirectory = '%INSTALL_DIR%'; $Shortcut.Save()"

echo.
echo Installation completed!
echo Binary installed to: %INSTALL_DIR%\vikey-inference-win.exe
echo.
echo You can run the application from Start Menu or from the command prompt with: vikey-inference-win
echo.

pause 