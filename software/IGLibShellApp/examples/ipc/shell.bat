
ECHO off
REM Initialization:
CALL settings.bat
ECHO.
ECHO Shell program: %IgShell%
ECHO Command-line arguments: %*
ECHO.

echo. 
echo StarTing shell ...
echo.

start %IgShell% %*

echo.
echo ... shell started.
echo.
