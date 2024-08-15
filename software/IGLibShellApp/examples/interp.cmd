
C ***********************************************************
C   Various examples of use of the command-line interpreter
C ***********************************************************

C C Remarks:
C C This contains examples of use of interpreter. In order to run examples,
C C run the command-line interpreter in interactive mode(e.g. by runnning
C C "shellProgram Interactive" where shlProgram is a valid IGLib shell
C C  application, such as igs.exe, which can be downloaded from
C C   http://www2.arnes.si/~ljc3m2/igor/software/IGLibShellApp/#download 
C C If you have an IGLib shell application named "igs.exe" in your path
C C then simply type the following in the operating system command prompt:
C C   igs.exe Interactive
C C On Linux, you will need to install the mono framework and run the
C C program by the mono application, e.g.
C C   mono igs.exe Interactive
C C When in interactive mode of the shell, you can execute the commands one
C C by one, and you can copy sample commands from this file to the command
C C prompt. Copy commands without the leading C characters, which indicate 
C C that everything that follows in that line is a comment. 
C C In this file, example commands are commented by a single C character,
C C and you can also uncomment the desired commands by deleting all the 
C C leading C characters and run the entire file by the "Run" command:
C C   igs.exe Run interp.cmd

C C The writeline commands below are just for indication if you run this 
C C command file via the Run command:
writeline 
writeline "This is printed from the interp.cmd"
writeline 

C =========================================
C RUNNING INTERNAL APPLICATIONS through command-line interpreter:

C C IGLib shells have built in a number of internal applications that can
C C be invoked via commans-line interpreter by invoking the corresponding
C C internal application classes' functions. 
C C An example is the "IG.Script.AppBase System" application group.

C C In order to print help for such an application group, with list of 
C C its commands, do the following:
C Internal IG.Script.AppBase System ?

C Print help on internal command, e.g. "Info":
C Internal IG.Script.AppBase System Info ?

C C Execute the command (in this case, "Info" command of the "System" group
C C of the internal class "IG.Script.AppBase"):
C C Internal IG.Script.AppBase System Info

C C Some commands can have arguments, as s.g. the "CurrentDirectory"
C C comand of the "File" group of the application class "IG.Script.AppBase".
C C The first line (CurrentDirectory command called without arguments) just
C C prinnt the current directory, and the second one also changes the current
C C directory to the specified path:
C Internal IG.Script.AppBase File CurrentDirectory 
C Internal IG.Script.AppBase File CurrentDirectory ../

C C Other example scripts (with .cmd extension) contain a number of other 
C C examples of using built-in internal command-line application classes.


C =========================================
C BASIC INTERPRETER utilities:

C C Print information about application:
C C by AppInfor or ApplicationInfo:
C C ApplicationInfo infoLevel includeIglib versionLevels ass1 ass2 ...
C C   infoLevel - level of information (1 - only basic, default 2)
C C   includeIglib - whether information on IGLib base library is included,
C C     default is yes
C C   versionLevels: number of levels in version information, default 2,
C C     0 means versionLevels is one more than infoLevel
C C   ass1 ass2 ...: simple names of additional assemblies whose info is added
C ApplicationInfo 5 yes 2  IGLibForms  mscorlib  System 
C C by About:
C About 4 yes 2 






