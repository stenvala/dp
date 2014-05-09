%% setInitReaderProperties.m
%
% init reader properties, for example element permutations
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setInitReaderProperties(this)

this.reader.supportedTypes.names = {'vtx','edg','tri','quad','tet','hex','pri','pyr','edg2','tri2','tet2'};
this.reader.supportedTypes.vertices = [1 2 3 4 4 8 6 5 3 6 10]; % these are corresponding vertice numbers
this.reader.supportedTypes.dimension = [0 1 2 2 3 3 3 3 1 2 3]; % these are dimensions of supported types
this.reader.supportedTypes.comsol.names = {'vtx','edg','tri','quad','tet','hex','pri','pyr'};
this.reader.supportedTypes.gmsh.types = [15 1 2 3 4 5 6 7 8 9 11]; % these are gmsh types
% comsol and gmsh don't have the nodes of elements in the same order, here
% we use gmsh order and thus permute comsol elements
this.reader.comsol.permutation.quad = full(sparse(1:4,[1,3,4,2],ones(1,4)));
this.reader.comsol.permutation.hex = full(sparse(1:8,[1,3,4,2,5,7,8,6],ones(1,8)));
this.reader.comsol.permutation.pyr = full(sparse(1:5,[1,3,4,2,5],ones(1,5)));
