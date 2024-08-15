
writeline "BEGIN: pipeserver command script."

set OutputLevelServer 2
C Run common.cmd in order to obtain server's output level:
try run common.cmd

PipeServer TestPipe TestPipe false $OutputLevelServer

writeline "END: pipeserver command script."

