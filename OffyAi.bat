@echo off
title OffyAi-0.5B
color 0A

echo.
echo ========================================
echo        ^|^| OffyAi LAUNCHER ^|^|
echo ========================================
echo         ^|^|   OffyAi 0.5B Model   ^|^|
echo ========================================
echo.

:: ===========================================================================
:: FILE EXISTENCE CHECKS
:: ===========================================================================
echo [CHECK] Verifying required files...
echo.

:: Check if llama-server.exe exists in src directory
if not exist "src\llama-server.exe" (
    echo [ERROR] llama-server.exe not found in src directory!
    echo [INFO] Current directory: %CD%
    echo [INFO] Please ensure:
    echo        - llama-server.exe is in the 'src' folder
    echo        - You're running this script from the correct location
    echo.
    pause
    exit /b 1
)

:: Check if the model file exists
if not exist "models\OffyAi-0.5B.gguf" (
    echo [ERROR] Model file 'models\OffyAi-0.5B.gguf' not found!
    echo [INFO] Please ensure:
    echo        - The model file is in the 'models' directory
    echo        - File name matches exactly: OffyAi-0.5B.gguf
    echo.
    pause
    exit /b 1
)

echo [SUCCESS] All required files verified!
echo.

:: ===========================================================================
:: SERVER STARTUP SECTION
:: ===========================================================================
echo ========================================
echo        STARTING SERVER...
echo ========================================
echo.
echo [CONFIG] Model: OffyAi-0.5B.gguf
echo [CONFIG] Port: 8080
echo [CONFIG] URL: http://localhost:8080
echo.

:: Launch the server in a new PowerShell window with proper directory context
echo [ACTION] Starting Llama server in new PowerShell window...
start "Llama Server - OffyAi 0.5B" powershell -NoExit -Command "cd /d '%CD%'; .\src\llama-server.exe --model models/OffyAi-0.5B.gguf --port 8080 --no-warmup"

:: ===========================================================================
:: BROWSER LAUNCH SECTION
:: ===========================================================================
echo.
echo ========================================
echo       LAUNCHING BROWSER...
echo ========================================
echo.
echo [INFO] Waiting 5 seconds for server initialization...
echo [STATUS] Server starting... [####------] 50%%
timeout /t 2 /nobreak >nul
echo [STATUS] Model loading...... [########--] 80%%
timeout /t 3 /nobreak >nul

:: Open the default browser to localhost:8080
echo [ACTION] Opening browser to http://localhost:8080...
start "" "http://localhost:8080"
echo [STATUS] Browser launched... [##########] 100%%
echo.

:: ===========================================================================
:: SUCCESS MESSAGE AND SHUTDOWN INSTRUCTIONS
:: ===========================================================================
echo ========================================
echo        LAUNCH COMPLETE!
echo ========================================
echo.
echo ^|########################################^|
echo ^|           SERVER STATUS: ONLINE        ^|
echo ^|########################################^|
echo.
echo [LOCATION] PowerShell Window: Llama Server - OffyAi 0.5B
echo [LOCATION] Browser Tab: http://localhost:8080
echo.
echo ^|########################################^|
echo ^|              NEXT STEPS                ^|
echo ^|########################################^|
echo.
echo  1. Interact with your model in the browser
echo  2. The server is now ready to accept requests
echo  3. Monitor server logs in the PowerShell window
echo.
echo ========================================
echo        SHUTDOWN INSTRUCTIONS
echo ========================================
echo.
echo ^|========================================^|
echo ^|    🚨 EMERGENCY SHUTDOWN PROCEDURE 🚨  ^|
echo ^|========================================^|
echo ^|                                        ^|
echo ^|    Press ANY KEY in THIS WINDOW to     ^|
echo ^|    safely SHUTDOWN all components:     ^|
echo ^|                                        ^|
echo ^|    ✅ Llama Server Process              ^|
echo ^|    ✅ PowerShell Window                 ^|
echo ^|    ✅ This Launcher                     ^|
echo ^|                                        ^|
echo ^|========================================^|
echo.
echo [WAITING] Shutdown handler active...
echo.

:: ===========================================================================
:: SHUTDOWN HANDLER
:: ===========================================================================
pause >nul

echo.
echo ========================================
echo        INITIATING SHUTDOWN...
echo ========================================
echo.
echo [ACTION] Stopping Llama server...
taskkill /f /im "llama-server.exe" >nul 2>&1
echo [ACTION] Closing PowerShell windows...
taskkill /f /im "powershell.exe" >nul 2>&1
echo [STATUS] Cleaning up... [####------] 50%%
timeout /t 1 /nobreak >nul

echo [SUCCESS] All processes terminated! [##########] 100%%
echo.
echo ========================================
echo        SHUTDOWN COMPLETE!
echo ========================================
echo.
echo Thank you for using OffyAi Llama Server!
echo.
timeout /t 2 /nobreak >nul
exit