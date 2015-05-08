Poisson problem
==

This is the main program (`main.m`) that utilizes your general 2-D Laplace solver which you have extended to Poisson problems.
You will add to your Laplace solver possibility to add piecewise constant sources making it a Poisson solver.
Again you will work only with translation symmetric cases (Cartesian metric).

Then, your solver can run problems like the one posed in `main.m` and post processed in `pp.m`.

When you return your lab, add a pdf file that explains what you did and presents the solution of the example problem.

You need to modify your `dp.solvers@poisson` object.

In addition, you develop post-processing facilities to `dp.@postProcess`.

The example problem represents one quarter of a dipole magnet. The given material parameters are inverses of relative permeabilities. 
In the post processing you will
- compute the inductance [H/m] when the coil has 100 turns
for this, the best choice is to add an energy computation to `dp.@postProcess` and take care of inductance in the main file based on this
- add functionality that displays the solution as a surface, like the simple post-processing in lab 1, but now you add it as a method to `dp.@postProcess`. Check how all the plotting is done in `dp.@mesh`.
- add method to `dp.@postProcess` that allows you to plot norm of magnetic flux density
- add method to `dp.@postProcess` that allows you to plot gradient (actually exterior derivative) of the potential and 2-D rotor (hodge exterior derivative)

Solution should look like this

![mesh](https://raw.githubusercontent.com/stenvala/dp/master/labs/lab2/figSolution.png)

Norm of magnetic flux density should look like this

![mesh](https://raw.githubusercontent.com/stenvala/dp/master/labs/lab2/figNormGrad.png)

And the gradient picture could look like this (after the rotation of the field)

![mesh](https://raw.githubusercontent.com/stenvala/dp/master/labs/lab2/figGrad.png)

