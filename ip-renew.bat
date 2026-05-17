@echo off
::NET SESSOIN >nul 2>&1
:: Check if app has run as Administartor
::IF %errorLevel% neq 0 (
::    ECHO Requesting administrator privileges...
::    POWERSHELL START -verb RUNAS '%0'
::    EXIT /b
::)

ECHO Clering and renewing IP Address...
IPCONFIG /release
IPCONFIG /renew
IPCONFIG /flushdns
IPCONFIG /registerdns
::NETSH winsock reset
::NETSH int ip reset

ECHO =============================================
ECHO Clearing and Renewing IP Address Complete^^!^^!^^!
ECHO =============================================
ECHO.
PAUSE