

C Print help for the script, with list of commands:
C Internal IG.Script.ScriptExtGraphics3d ?
C Internal IG.Script.ScriptGraphics3DBase ?

C Internal IG.Script.ScriptExtGraphics3d Custom3d


C Print help for Surface3D, with list of surfaces: 
C Internal IG.Script.ScriptGraphics3DBase Surface3D ?

C Print help for the KleinBottle surface:
C Internal IG.Script.ScriptGraphics3DBase Surface3D KleinBottle ?

C plot surface with specified resolution and bounds (overriding default values):
C Internal IG.Script.ScriptGraphics3DBase Surface3D KleinBottle 80 40 0.0 1.0 0.0 1.0

C **************
C Various surface plots:

C Internal IG.Script.ScriptGraphics3DBase Surface3D KleinBottle 

C Internal IG.Script.ScriptGraphics3DBase Surface3D TwoToruses 

C Internal IG.Script.ScriptGraphics3DBase Surface3D SnailShell 



C **************
C VTK tests:
C Instructions: when graphic window appears, press the 'r' key if the plot is
C not centered or zoomed correctly!

C Check which tests are available:
C Internal IG.Script.ScriptGraphics3DBase VtkTest ? 

C Run various VTK tests:

C Internal IG.Script.ScriptGraphics3DBase VtkTest StructuredGrid 20 20 3

C Internal IG.Script.ScriptGraphics3DBase VtkTest QuadCells 20 20

C Internal IG.Script.ScriptGraphics3DBase VtkTest CellGridContours 20 20 20

C Internal IG.Script.ScriptGraphics3DBase VtkTest StructuredGridVolumeContours 20 20 4
C C The came command by derived script (available in shellext.exe):
C Internal IG.Script.ScriptExtGraphics3d VtkTest StructuredGridVolumeContours 20 20 4


C C ****
C C VTK Forms:
C C Advanced form with controls:
C C Internal IG.Script.ScriptGraphics3DBase Plot3d VtkControl formType modal 
C C     testPlotter testActorsIGLib testActorsVTK
C C formType: type of the form ('plain', 'vtk')
C C modal: if true then form is launched as modal form
C C testPlotter: if true then some test IGLib graphics is plotted on the form through plotter
C C testActorsIGLib: if true then some test IGLib graphics is plotted on the form internally
C C testActorsVTK: if true then some test VTK graphics is added internally
C C Default values for boolean parameters are true ('1', 'y', 'yes', 'on')
C C 
Internal IG.Script.ScriptGraphics3DBase Plot3d VtkControl
C C Plain form with only a VTK control:
C Internal IG.Script.ScriptGraphics3DBase Plot3d VtkControl plain
C C VTK form from VTK examples:
C Internal IG.Script.ScriptGraphics3DBase Plot3d VtkControl vtk
C C More parameters defined:
C Internal IG.Script.ScriptGraphics3DBase Plot3d VtkControl vtk 1 1 1 1

C C  **************
C C 3D plots:
C C Instructions: when graphic window appears, press the 'r' key if the plot is
C C not centered or zoomed correctly (before this, make the window active by 
C C clicking on it)!
C C Other useful commands: 
C C 'j'/'t' - jojstick / trackball mode, 'c'/'a' - camera / actor mode (in the
C C latter, mouse events affect object under the pointer rather than camera),
C C 's'/'w' - all actors represented as surfaces, 'f' - fly-to the point under
C C the cursor (allowing rotations about that point), 'r' - resets the camera
C C (centers actors, all become visible).

C Check which tests are available:
C Internal IG.Script.ScriptExtGraphics3d Plot3d ? 

C Run various 3D graphics tests:

C Internal IG.Script.ScriptGraphics3DBase Plot3d CurvePlotLissajous 

C Internal IG.Script.ScriptGraphics3DBase Plot3d SurfaceComparison 

C Internal IG.Script.ScriptGraphics3DBase Plot3d SurfacePlot 

C Internal IG.Script.ScriptGraphics3DBase Plot3d SurfacePlotScaled 30 30 

C Internal IG.Script.ScriptGraphics3DBase Plot3d SurfacePlotManualScaled 30 30 

C Internal IG.Script.ScriptGraphics3DBase Plot3d ContourPlot 
C C The same command by derived script (available in shellextext.exe):
C Internal IG.Script.ScriptExtGraphics3d Plot3d ContourPlot 

C C Demonstartio of decorations (axes, scalar bar, etc.)
C Internal IG.Script.ScriptGraphics3DBase Plot3d Decoration 




C **************
C 2D graphs:

C Check which tests are available:
C Internal IG.Script.ScriptGraphics2dBase Graph ? 

C Run various Graph tests:

C Internal IG.Script.ScriptGraphics2dBase Graph CurvePlotLissajous 5 4

C Internal IG.Script.ScriptGraphics2dBase Graph SinePlots 3 200

C Internal IG.Script.ScriptGraphics2dBase Graph Decorations

C Internal IG.Script.ScriptGraphics2dBase Graph CurveStylesWithSave %temp%/test.bmp
CC If the above does not work, extract %temp% explicitly:
C Internal IG.Script.ScriptGraphics2dBase Graph CurveStylesWithSave C:\Users\Igor\AppData\Local\Temp\test.bmp









