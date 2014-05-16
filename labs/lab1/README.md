Laplace problem
==

This is a main program that utilizes your general 2-D Laplace solver.
You will develop Laplace solver with following properties
- 1st and 2nd order basis functions
- piecewise constant material parameters that are represented with scalars
- homogeneous Neumann boundary conditions
- homogeneous and non-homogeneous piecewise constant Dirichlet boundary conditions

Then your solver can run problems like the one posed in main.m

When you return your lab, add a pdf file that explains what you did and presents the solution of the example problem.
Also, present a figure that visualizes the difference between solutions obtained with first and second order basis functions.

You need to modify following classes
@dpSolver <- add your solver here with methods:
- constructor
- initLaplace(struct defining boundary conditions, struct defining domain properties)
- solveLaplace(dpMesh object)
- getLaplaceSolutionAtNode() note for second order element returns solution only at the nodes

@dpMeshPro <- this is inherited from @dpMesh, don't modify it but modify this
You need to add some methods (and properties possibly) that consider 
- basis functions
- Gauss points etc
This is up to you. Separate mesh related methods here and don't put those to @dpSolver.