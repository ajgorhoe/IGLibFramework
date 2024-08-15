
ECHO off
REM Initialization:
CALL settings.bat
ECHO
ECHO Shell program: %IgShell%
ECHO

echo Starting pipe server...
call %IgShell% Interactive Run pipeserver.cmd
echo ... server started.

