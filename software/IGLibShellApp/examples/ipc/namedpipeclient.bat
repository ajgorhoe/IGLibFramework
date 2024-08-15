
ECHO off
REM Initialization:
CALL settings.bat
ECHO
ECHO Shell program: %IgShell%
ECHO

echo StarTing pipe client...
call %IgShell% Interactive Run pipeclient.cmd
echo ... client started.

