Laplace problem
==

This is the introduction for the first computer exercise return problem.

The main program is in script `main.m` which should be at the end, meaning when you return your problem, executable successfully by pressing F5.
The main program utilizes your general 2-D Laplace solver.

You will develop Laplace solver with following properties
- 1st and 2nd order basis functions in triangles (superparametric representation i.e. linear transition chart from standard triangle)
- piecewise constant material parameters that are represented with scalars
- homogeneous Neumann boundary conditions
- homogeneous and non-homogeneous piecewise constant Dirichlet boundary conditions
- cartesian metric

Then, your solver can run problems like the one posed in main.m (but it must also handle other that are similarly posed)

When you return your lab, add a pdf file that explains what you did and it also presents the solution of the example problem.
In addition, perform small parametric analysis (parameter is the mesh density coefficient, but you should report it as the number of DoFs), compute the solution with 1st and 2nd order basis functions and integrate the power. 
Include in your return the power convergence plots as a function of number of DoFs for both the basis function orders.
You can change the CharScale parameter to scale the mesh element size in main.m.

You need to modify only following classes in their corresponding folders:

`dp.solvers.@poisson` <- add your solver here with methods:
- constructor
- solve(dpMesh object)
- getSolutionAtNodes()
- integrateEnergy(), this computes the dissipated power exactly based on the solution

`dp.@meshPro` <- this is inherited from `dp.@mesh`, don't modify `dp.@mesh` but modify this
You need to add some methods (and properties possibly) that consider at least basis functions and Jacobians.
This is up to you. Separate mesh related methods here and don't put those to your solver.

The mesh for the example geometry looks like this

![mesh](https://raw.githubusercontent.com/stenvala/dp/master/labs/lab1/figMesh.png)

Your solution should look like this

![mesh](https://raw.githubusercontent.com/stenvala/dp/master/labs/lab1/figSolution.png)

