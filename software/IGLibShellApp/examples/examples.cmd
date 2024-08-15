
C *********************************************
C Various examples run through internal scripts
C *********************************************

C ****************************************************************************
C WARNNG:
C Some examples in this script will only work with extended shell, which is
C not publically available. 
C *************************

C Remarks:
C Scripts are invoked by the Internal command followed by the full name of
C the script class (including the namespace, e.g. 
C IG.Script.ScriptExtFormats) followed by eventual commands & arguments.

C Print help for the script, with list of its internal commands:
C Internal IG.Script.ScriptExtFormats ?

C Print help on internal command:
C Internal IG.Script.ScriptExtFormats Custom ?


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
C PipeClient TestPipe TestPipe false 0

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


C TEST OF FORMATS:


C Basic fomatting demonstration:
C Internal IG.Script.ScriptExtFormats Format 


C Checks whether the script runs correctly (will also print arguments):
C Internal IG.Script.ScriptExtFormats TestScript 


C BASIC NUMERICS:

C C Scalar function objects defined through string expressions:
C Internal IG.Script.AppBase Numerics ScriptScalarFunction


C TEST OF NUMERICAL PROCEDURES:

C C List of commands:
C Internal IG.Script.ScriptExtNumeric ?

C Test of parallel jobs:
C Internal IG.Script.ScriptExtNumeric ParallelJobs

C C Test of scalar functions:
C Internal IG.Script.ScriptExtNumeric ScalarFunctions


C VARIOUS EXAMPLES:

C C List of commands:
C Internal IG.Script.ScriptExtExamples ?

C C 3D graphics demonstration:
C Internal IG.Script.ScriptExtExamples Graphics3d 

C C Clouds of points:
C Internal IG.Script.ScriptExtExamples PointClouds 





C C Some CUSTOM TESTS:

C C Custom example for using functions of type RealFunction (from AppIgorGresovnik.cs):
C ExFunction 

C C Custom example for using vectors (from AppIgorGresovnik.cs):
C ExVector 

C C Custom graphics examples (from AppIgorGresovnik.cs):
C ExGraphics a1 a2




