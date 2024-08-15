
writeline "BEGIN: Speed test script."

Set NumExecutions 10000
Set Command "Set a 22"
WriteLine "Comand to be run: " ' $Command '
WriteLine "Number of executions: " $NumExecutions

Repeat $NumExecutions Set a 22

writeline "END: speed test script."

