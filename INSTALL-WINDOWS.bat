@echo off
setlocal
cd /d "%~dp0"
title JARVIS installer
echo.
echo ===== JARVIS installer (Windows) =====
echo.

where node >nul 2>nul
if errorlevel 1 (
  echo [1/4] Node.js not found - installing it with winget...
  winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
  if errorlevel 1 (
    echo.
    echo Could not install Node.js automatically.
    echo Install it from https://nodejs.org ^(LTS^), then double-click this file again.
    start https://nodejs.org
    pause
    exit /b 1
  )
  echo.
  echo Node.js installed. CLOSE this window and double-click INSTALL-WINDOWS.bat again.
  pause
  exit /b 0
)
echo [1/4] Node.js found:
node -v

where claude >nul 2>nul
if errorlevel 1 (
  echo [2/4] Installing Claude Code...
  call npm install -g @anthropic-ai/claude-code
) else (
  echo [2/4] Claude Code already installed.
)

echo [3/4] Installing JARVIS packages ^(this can take a few minutes^)...
call npm install
if errorlevel 1 (
  echo npm install failed - see the messages above.
  pause
  exit /b 1
)

echo.
echo [4/4] Checking your setup...
call npm run setup
echo.
echo IMPORTANT: if you have never logged in to Claude Code, a login will open now.
echo Finish the login, then type /exit to come back here.
pause
call claude

echo.
echo Starting JARVIS. Chrome will open at http://localhost:5173
echo Click INITIALISE, allow the microphone, and say "Hey Jarvis".
echo Keep this window open while you use JARVIS. Close it to stop.
start "" /min powershell -NoProfile -Command "for($i=0;$i -lt 120;$i++){try{$null = Invoke-WebRequest -UseBasicParsing http://localhost:5173 -TimeoutSec 2; Start-Process http://localhost:5173; break}catch{Start-Sleep 1}}"
call npm start
pause
