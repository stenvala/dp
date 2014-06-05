Example of generating own meshes and adding to the structure
==

In main.m and main2.m we generate rectangular and triangular meshes for a disc in two different ways. Idea is to first generate a rectangular mesh and then subdivide it into a triangular one. Then, we add the meshes to a dpMesh object and save those as .msh files. We also remove duplicate or unused nodes we generate during the meshing procedure.