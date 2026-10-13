@echo off
cd /d "%~dp0"
title JARVIS
start "" /min powershell -NoProfile -Command "for($i=0;$i -lt 120;$i++){try{$null = Invoke-WebRequest -UseBasicParsing http://localhost:5173 -TimeoutSec 2; Start-Process http://localhost:5173; break}catch{Start-Sleep 1}}"
call npm start
pause
