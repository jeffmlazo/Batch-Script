@echo off
echo Releasing IP address...
ipconfig /release

echo.
echo Waiting for releasing to complete...
timeout /T 3 /nobreak >nul

echo.
echo Renewing IP addres...
ipconfig /renew

echo.
echo Renew Complete!
pause
