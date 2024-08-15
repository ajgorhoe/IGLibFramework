
writeline "BEGIN: pipeclient command script."


set OutputLevelClient 2
C Run common.cmd in order to obtain client's output level:
try run common.cmd


PipeClient TestPipe TestPipe false $OutputLevelClient
PipeClientSend TestPipe Calc 3+5


writeline "END: pipeclient command script."

