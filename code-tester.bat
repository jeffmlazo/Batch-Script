@echo off
setlocal enabledelayedexpansion

:: Get connection-specific DNS suffix (domain)
::for /F "tokens=2 delims=:" %%a in ('systeminfo ^| findstr /c:"Domain"') do (
::	set "DOMAIN=%%a"
::	echo "DOMAIN=!"
::)

:: START find & display domain name ==========================
::set "DOMAIN=%DOMAIN: =%"
::echo Fetching domain name = %DOMAIN%
::findstr /c:"Domain"
::systeminfo | findstr /c:"Domain"
::echo Domain: %domain%
:: END find & display domain name ==========================

:: START Get server IP address ==========================
:: set "DOMAIN-NAME=SGS.com"

rem for /F "tokens=2 delims=:" %%a in ('nslookup %DOMAIN-NAME% ^| findstr /c:"Address:" ^| findstr /v "#"') do (
rem 	set "SERVER-IP=%%a"
rem		set "SERVER-IP=!SERVER-IP: =!"
rem 	goto :found
rem )
rem :found

:: echo Server IP: %SERVER-IP%
:: END Get server IP address ==========================

:RETRY_TESTER
echo Start Domain tester
set /P ROLE="Press 1 for Client, 2 for Server: "

if "%ROLE%"=="1" (
	echo Client host is selected
) else if "%ROLE%"=="2" (
	echo Server host is selected
) else (
	set /P IS_RETRY="Invalid selected host. Do you want to start the selection again? [Y/n]"
	if /I "!IS_RETRY!"=="Y" (
		goto RETRY_TESTER
	) else if /I "!IS_RETRY!"=="N" (
		goto END_APP
	) else (
		echo You entered an invalid selection...
		goto END_APP
	)
)
:END_APP
pause
