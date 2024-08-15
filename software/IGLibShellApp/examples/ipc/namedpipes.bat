

ECHO off

CALL settings.bat

ECHO Shell program: %IgShell%

echo starting pipe server...
start %IgShell% Interactive Run pipeserver.cmd
echo ... server started.

echo waiting for %1 seconds...
timeout %1


echo StarTing pipe client...
start %IgShell% Interactive Run pipeclient.cmd
echo ... client started.
