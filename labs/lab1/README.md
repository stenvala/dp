Laplace problem
==

This is the main program (main.m) that utilizes your general 2-D Laplace solver.
You will develop Laplace solver with following properties
- 1st and 2nd order basis functions
- piecewise constant material parameters that are represented with scalars
- homogeneous Neumann boundary conditions
- homogeneous and non-homogeneous piecewise constant Dirichlet boundary conditions
- Cartesian metric

Then, your solver can run problems like the one posed in main.m

When you return your lab, add a pdf file that explains what you did and presents the solution of the example problem.
Compute the solution with 1st and 2nd order basis functions and integrate the power. 
Include in your return the power convergence plots as a function of amount of degrees of freedoms for both the basis function orders.
You can change the CharScale parameter to scale the mesh element size in main.m.
Also, present a figure that visualizes the difference between solutions obtained with first and second order basis functions.

You need to modify following classes
@dpSolver <- add your solver here with methods:
- constructor
- initLaplace(struct defining boundary conditions, struct defining domain properties)
- solveLaplace(dpMesh object)
- getLaplaceSolutionAtNodes() note, for second order element this returns solution only at the corner nodes
- laplaceIntegratePower(), this computes the dissipated power

@dpMeshPro <- this is inherited from @dpMesh, don't modify @dpMesh but modify this
You need to add some methods (and properties possibly) that consider 
- basis functions
- Gauss points etc
This is up to you. Separate mesh related methods here and don't put those to @dpSolver.