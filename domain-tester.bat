@echo off
setlocal enabledelayedexpansion

:: Start Domain Tester
:: Press 1 for Client or 2 for Server

echo ================================
echo Fetching server domain...
:: Get connection-specific DNS suffix (domain)
for /F "tokens=2 delims=:" %%a in ('systeminfo ^| findstr /c:"Domain"') do (
	set "DOMAIN=%%a"
	::echo "DOMAIN=!"
	:: Remove spaces and set again the DOMAIN variable and store it again
	::set "DOMAIN=%DOMAIN: =%"
	set "DOMAIN=!DOMAIN: =!"
	goto :found1
)
:found1
echo ================================

echo ================================
echo Fetching server IP address...
set DOMAIN-NAME=%DOMAIN%
:: Get server IP address
for /F "tokens=2 delims=:" %%a in ('nslookup %DOMAIN-NAME% ^| findstr /c:"Address:" ^| findstr /v "#"') do (
	set "SERVER-IP=%%a"
	set "SERVER-IP=!SERVER-IP: =!"
	goto :found2
)
:found2
echo ================================

echo.
echo =====================================================
set SERVER-IP-ADDRESS=%SERVER-IP%
set CLIENT-IP-ADDRESS=129.29.29.6
echo Testing domain name [%DOMAIN-NAME%] using domain name and nslookup...
echo =====================================================
nslookup %DOMAIN-NAME%

echo =====================================================
echo Testing domain using server IP address [%SERVER-IP-ADDRESS%] and nslookup...
echo =====================================================
nslookup %SERVER-IP-ADDRESS%

echo ================================
echo Pinging server using server IP address [%SERVER-IP-ADDRESS%]...
echo ================================
ping %SERVER-IP-ADDRESS%

echo.
echo ================================
echo Pinging client using IP address [%CLIENT-IP-ADDRESS%]...
echo ================================
ping %CLIENT-IP-ADDRESS%

echo.
echo ================================
echo Domain tester complete!!!
echo ================================
pause
