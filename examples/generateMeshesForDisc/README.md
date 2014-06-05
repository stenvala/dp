Example of generating own meshes and adding to the dpMesh object instance
==

In main.m and main2.m we generate rectangular and triangular meshes for a disc in two different ways. Idea is to first generate a rectangular mesh and then subdivide it into a triangular one. Then, we add the meshes to a dpMesh object and save those as .msh files. We also remove duplicate or unused nodes we generate during the meshing procedure. 

In main.m we try to represent the disc with squares of the same size. 

In main2.m we use quadrangles which. We construct those in such a way that on the boundary, the quadrangle takes the same length of the perimeter inside. Then we match all the edges of the quadrangles. Correspondingly, the edge representation of the circle is very good.