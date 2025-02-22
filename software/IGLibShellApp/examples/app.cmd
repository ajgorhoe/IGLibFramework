
C **********************************************************
C Various embedded applications run through internal scripts
C **********************************************************

C Remarks:
C Scripts are invoked by the Internal command followed by the full name of
C the script class (including the namespace, e.g. 
C IG.Script.AppBase) followed by eventual commands & arguments.
C IG.Script.AppShellExt is extension of IG.Script.AppBase

C Print help for the script, with list of its internal commands:
C Internal IG.Script.AppBase ?

C C Print help on embedded application:
C Internal IG.Script.AppBase CustomApp ?

C C Print help on group of embedded applications:
C Internal IG.Script.AppBase File ?


C C Embedded application that only prints its commandline arguments:
C Internal IG.Script.AppBase Custom PrintArguments Arg1 Arg2

C The same application run through derived script class:
C Internal IG.Script.AppShellExt Custom PrintArguments Arg1 Arg2

C =========================================
C FILE SYTEM - related custom applications:

C C Print Installed applications: 
C Internal IG.Script.AppBase File ?

C C Just print application arguments (test application): 
C Internal IG.Script.AppBase File PrintArguments arg1 arg2

C C Register and log file events in the current dir.:
C runasync Internal  IG.Script.AppBase File LogEvents ./

C C Wait for creation of the file test.txt:
C runasync Internal  IG.Script.AppBase File WaitCreation test.txt 

C C Wait for creation of the file test.txt, no automatic return if
C C the file already exists:
C runasync Internal  IG.Script.AppBase File WaitCreation test.txt false

C C Get relative path of a directory:
C C Internal IG.Script.AppBase File RelativePath TargetPath [InitialPath]
C C  Prints the relative path of TargetPath with respect to InitialPath
C C    TargetPath: path whose relative path is calculated
C C    InitialPath: path to directory with respect to which the relative path
C C      is calculated. If not specidied it is the current directory.
C Internal IG.Script.AppBase File RelativePath ipc/speedtest.cmd ../../../
C Internal IG.Script.AppBase File RelativePath ipc/speedtest.cmd 

C C Get standardized path of a directory:
C Internal IG.Script.AppBase File StandardPath ../../
C Internal IG.Script.AppBase File StandardPath 

C C Get or set current directory:
C Internal IG.Script.AppBase File CurrentDirectory ../
C Internal IG.Script.AppBase File CurrentDirectory 


C =========================================
C SYTEM - related custom applications:

C C Print Installed applications: 
C Internal IG.Script.AppBase System ?

C C Print most relevant system information: 
C Internal IG.Script.AppBase System Info

C C Print and return version of the runtime where application runs: 
C Internal IG.Script.AppBase System RuntimeVersion

C C Print and return current user name: 
C Internal IG.Script.AppBase System UserName

C C Print and return current computer name: 
C Internal IG.Script.AppBase System ComputerName

C C Print and return current domain name: 
C Internal IG.Script.AppBase System DomainName

C C Print and return current IP address: 
C Internal IG.Script.AppBase System IpAddress

C C Print and return MAC address of the current computer: 
C Internal IG.Script.AppBase System MACAddress


C =========================================
C ASSEMBLIES - related custom applications:

C C Print and return assembly info (no arguments - the IGLib info is printed): 
C C Internal IG.Script.AppBase Assembly Info [AssemblyName] [AlsoByFileName]
C C   AssemblyName: name of the assembly whose info is printed.
C C     If not specified then the IGLib assembly is taken.
C C   AlsoByFileName: if true then assemblies are also searched by file names.
C C     Default is true.
C Internal IG.Script.AppBase Assembly Info 
C Internal IG.Script.AppBase Assembly Info IGLibForms 
C Internal IG.Script.AppBase Assembly Info IGLibForms.dll 
C Internal IG.Script.AppBase Assembly Info IGLibForms.dll false

C C Get a list of referenced assemblies' names:
C C Internal IG.Script.AppBase Assembly Referenced [Recursive]
C C If Recursive is True then indirectly referenced assemblies are added
C C recursively (default is false).
C Internal IG.Script.AppBase Assembly Referenced 
C Internal IG.Script.AppBase Assembly Referenced True
C Internal IG.Script.AppBase Assembly Referenced False



C =========================================
C PROCESS- related custom applications:

C Print Installed applications: 
C Internal IG.Script.AppBase Process ?

C List ALL running processes: 
C Internal IG.Script.AppBase Process ListProcesses "" 1 1


C List ALL running processes: 
C Internal IG.Script.AppBase Process ListProcesses 

C List ALL running applications: 
C Internal IG.Script.AppBase Process ListApplications 

C C General ways of listing processes and applications:
C C Internal IG.Script.AppBase Process Command <Name> <CaseSensitive> <FullName> <PrintDetails>
C C Commands:
C C ListProcesses - lists all processes matching name and conditions
C C ListApplications - lists only applicatins - processes with main window 
C C ListApplicationsByWindow: - lists applications by main window title
C C Name: process/window name of item to be listed (if none then all are listed)
C C CaseSensitive: whether name is case sensitive, default false
C C FullName: if false then only substring of name/title can be specified, 
C C     default true except for window titles
C C PrintDetails: if true then details are printed

C C KillProcesses, KillApplications and KillapplicationsByWindow have similar
C C arguments (except that PrintDetails is not used).


C Several ways to list JMatPro, if running: 
C Internal IG.Script.AppBase Process ListProcesses JMatPro-4.0 false
C Internal IG.Script.AppBase Process ListApplications javaw false
C Internal IG.Script.AppBase Process ListApplicationsByWindow "JMatPro the materials property simulation software." false

C Several ways to list Firefox instances:
C Internal IG.Script.AppBase Process ListProcesses firefox true true true
C Since Firefox is an application with main window:
C Internal IG.Script.AppBase Process ListApplications firefox false true true
C List by window title:
C Internal IG.Script.AppBase Process ListApplications firefox false false true




C ============================================
C WINDOWS FORMS related embedded applications:

C Print Installed applications: 
C Internal IG.Script.AppExtBase FormDemo ?

C C Fading Message: 
C Internal IG.Script.AppExtBase FormDemo FadingMessage 

C C Browser form: 
C Internal IG.Script.AppExtBase FormDemo Browser 

C C Window Positioner:
C Internal IG.Script.AppExtBase FormDemo WindowPositioning  

C C Message box launcher
C Internal IG.Script.AppExtBase FormDemo MessageBoxLauncher


C ==============================================
C NEURAL NETWORKS related embedded applications:

C Run the ANN approximation demo:
C Internal IG.Script.AppShellExt NeuralDemo TestApp

C Run the ANN model - based parametric tests:
C Internal IG.Script.AppShellExt NeuralDemo ParametricTests


C C Some OLD Applications and Tests: 

C Run the OLD version of ANN approximation demo:
C Internal IG.Script.AppShellExt NeuralDemo TestAppOld

C Run the OLD version of 1D ANN approximation demo:
C Internal IG.Script.AppShellExt NeuralDemo TestApp1DOld

C Run the OLD version of 2D ANN approximation demo:
C Internal IG.Script.AppShellExt NeuralDemo TestApp2DOld








