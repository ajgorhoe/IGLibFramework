
C **********************************************
C Exemples of IPC - interprocess communication.
C **********************************************


C TEST OF NAMED PIPE SERVER:

C Just a test for named pipes:
C internal IG.Script.ScriptExtExamples NamedPipes
C internal IG.Script.ScriptExtExamples NamedPipeClient
C internal IG.Script.ScriptExtExamples NamedPipeServer

C C Create and start a named pipe server:
C C PipeServer PipeName <ServerName> <CreateCommand> <OutputLevel>
C C   PipeName: name of the pipe used for communication 
C C   ServerName: name of the server to reference by commands (same as PipeName by default)
C C   CreateCommand: Whether interpreter command with server name is also created
C C     for accessing the server (currently not used)
C C   OutputLevel: level of output
C PipeServer TestPipe TestPipe false 0

C C Start named pipe client (this must be done in another process):
C C PipeClient PipeName <HostAddress> < ClientName> <CreateCommand> <OutputLevel>
C C   PipeName: name of the double ended pipe used for communication
C C   HostAddress: address of computet on which server is running
C C   ClientName: Name by which client is accessed in interpreter commands (same as PipeName by default)
C C   CreateCommand: Whether interpreter command with client name is also created 
C C   OutputLevel: level of output
C PipeClient TestPipe TestPipe false 

C C Send some commands to the pipe server and see responses:
C C PipeClientSend ClientName Command <Arg1> <Arg2> ...
C C   ClientName: name of the client throgh which requests are sent
C C   Command: interpreter command to be sent to the server
C C   Arg1, Arg2, ...: optional arguments of the command
C PipeClientSend TestPipe Calc 3+5
C PipeClientSend TestPipe System dir
C Repeat 5 PipeClientSend TestPipe Set a 23
C PipeClientSend TestPipe Set a 23
C PipeClientSend TestPipe Get a
