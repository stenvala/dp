dp
==

Primitive object oriented platform for programming finite element method solvers in Matlab. Targeted to educational purposes. Some examples and exercise problems are provided. Solvers and e.g. basis functions are not included (students should implement those themselves).

Mesh generator is not included. The platform utilizes Gmsh for mesh generation and it can also read Comsol 4.x .mshtxt files. If you want to use Gmsh from dp, install it to dp/gmsh/ folder. In Windows, put gmsh.exe there to use it for mesh generation!

This platform is utilized in course Numerical Methods for Field Computations at Tampere University of Technology, Tampere, Finland. Students will program with this platform their own Galerkin FEM solvers for

- Laplace problems
- Poisson problems
- Linear isotropic elasticity (plane strain in 2-d)

Some useless/ful links.

- gmsh: http://geuz.org/gmsh/
- comsol: http://www.comsol.com/

To get started in Matlab, you need to run dpInit.m and look at examples folder and labs folder

- Also wiki pages are up and running: https://github.com/stenvala/dp/wiki