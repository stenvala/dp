Poisson problem
==

This is the main program (main.m) that utilizes your general 2-D Laplace solver which you have extended to Poisson problems.
You will add to your Laplace solver possibility to add piecewise constant sources making it a Poisson solver.
Again you will work only with translation symmetric cases (Cartesian metric).

Then, your solver can run problems like the one posed in main.m

When you return your lab, add a pdf file that explains what you did and presents the solution of the example problem.

You need to modify your @dpSolver

In addition, you develop post-processing facilities to @dpPostProcess.

The example problem represents one quarter of a dipole magnet. The given material parameters are inverses of relative permeabilities. 
In the post processing you will
- compute its inductance when it has 100 turns
for this, the best choice is to add an energy computation to @dpPostProcess and take care of inductance in the main file based on this
- add functionality that displays the solution as a surface, like the simple post-processing but with possibility to set axis
- add functionality that allows you to plot gradient (actually exterior derivative) of the potential and 2-D rotor (hodge exterior derivative)
