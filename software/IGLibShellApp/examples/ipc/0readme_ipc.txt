
INTERPROCESS COMMUNICATION EXAMPLES.

ipcexamples.cmd - contains examples form launching various applications that
    are embedded to shell interpreter.

settings.bat - sets environment variables that define how to start a shell.

shell.bat - runs the shell with specific command line arguments.

To DEBUG any of the examples found here:
  * Open the shell's software development project
  * Go to debug settings
  * Set current directory to this example directory, namely to:
    * ..\..\..\..\..\..\..\workspaceprojects\00tests\examples\ipc
  * Set command-line arguments to the appropriate command from one of the 
    examples. 
    * To run a command file, arguments are: 
	  Interactive Run pipeserver.cmd
	* To run a command file and then enter interactive mode:
	  Interactive Run pipeserver.cmd

TO RUN any of the examples here:
  * Run shell.bat with the appropriate command-line parameters, which are
      equivalent to those used for debugging
  * Or run any of the specialized batch files.	  
      These batch files are designed in such a way that they can be run
	  by double clicking in file explorer or form command prompt.

NAMED PIPES:

ipcexamples.cmd - shell command script for named pipes.

pipeclient.cmd - starts a named pipe client, sends it some test commands, and 
    goes to interactive mode.

pipeserver.cmd - starts a named pipe server in a parallel thread, and 
    goes to interactive mode.

namedpipeclient.bat - launches a pipe client

namedpipeserver.bat - launches a pipe server
	
namedpipes.bat - launches both pipe client and server, each in its own shell
    that runs in a separate window.	
	
