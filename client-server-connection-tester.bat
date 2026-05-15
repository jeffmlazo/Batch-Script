@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

:RETRY_TESTER
ECHO ============================================
ECHO = START CLIENT ^& SERVER CONNECTION TESTER =
ECHO ============================================
ECHO.

SET /P ROLE="Press 1 for Client, 2 for Server: "

SET MATCH=false
IF "%ROLE%"=="1" SET MATCH=true
IF "%ROLE%"=="2" SET MATCH=true

IF "!MATCH!"=="false" (
    SET /P IS_RETRY_TESTER="Invalid selected host. Do you want to start the selection again? [Y/N]: "
    IF /I "!IS_RETRY_TESTER!"=="Y" GOTO RETRY_TESTER
    IF /I "!IS_RETRY_TESTER!"=="N" GOTO END_APP
    ECHO You entered an invalid selection...
    GOTO END_APP
)

ECHO.
ECHO Test connection of Client or Server....
ECHO.

:RETRY_PING
IF "!ROLE!"=="1" GOTO FETCH_CLIENT
IF "!ROLE!"=="2" GOTO FETCH_SERVER

:FETCH_CLIENT
ECHO ================================
ECHO Fetching server domain...
FOR /F "tokens=2 delims=:" %%a IN ('systeminfo ^| findstr /c:"Domain"') DO (
    SET "DOMAIN=%%a"
    SET "DOMAIN=!DOMAIN: =!"
    GOTO FOUND_DOMAIN
)

:FOUND_DOMAIN
ECHO ================================
ECHO ================================
ECHO Fetching server IP address...
FOR /F "tokens=2 delims=:" %%a IN ('nslookup !DOMAIN! ^| findstr /c:"Address:" ^| findstr /v "#"') DO (
    SET "SERVER_IP=%%a"
    SET "SERVER_IP=!SERVER_IP: =!"
    GOTO FOUND_SERVER_IP
)

:FOUND_SERVER_IP
ECHO ================================
SET TARGET_IP=!SERVER_IP!
GOTO CHECK_IP

:FETCH_SERVER
SET /P TARGET_IP="Enter target IP address: "

:CHECK_IP
:: Check if IP address is not empty
IF "!TARGET_IP!"=="" (
    ECHO IP address cannot be empty.
    GOTO RETRY_PING
)

:: Pinging IP address
PING !TARGET_IP!

SET /P IS_RETRY_PING="Do you want to retry ping again? [Y/N]: "
IF /I "!IS_RETRY_PING!"=="Y" GOTO RETRY_PING
IF /I "!IS_RETRY_PING!"=="N" GOTO END_APP
ECHO You entered an invalid selection...
GOTO END_APP

:END_APP
ECHO.
ECHO =============================================
ECHO Client Server Connection Test Complete^^!^^!^^!
ECHO =============================================
ECHO.
PAUSE