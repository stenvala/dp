function setInitReaderProperties(this)
% Init reader properties, for example element permutations and supported types
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

% gather all information of element types
%% vertex
vtx = INT_initElement('vtx','Node or verted',1,0,{'gmsh',15,'comsol','vtx'});
%% edge
edg = INT_initElement('edg','Edge',2,1,{'gmsh',1,'comsol','edg'});
%% triangle
tri = INT_initElement('tri','Triangle',3,2,{'gmsh',2,'comsol','tri'});
%% quadrangle
quad = INT_initElement('quad','Quadrangle',4,2,{'gmsh',3,'comsol','quad'});
% add permutation for element order change (optional)
quad.permutation.comsol = full(sparse(1:4,[1,3,4,2],ones(1,4)));
%% tetrahedron
tet = INT_initElement('tet','Tetrahedron',4,3,{'gmsh',4,'comsol','tet'});
%% hexahedron
hex = INT_initElement('hex','Hexahedron',8,3,{'gmsh',5,'comsol','hex'});
hex.permutation.comsol = full(sparse(1:8,[1,3,4,2,5,7,8,6],ones(1,8)));
%% prism
pri = INT_initElement('pri','Prism',6,3,{'gmsh',6,'comsol','pri'});
% most likely prism needs to be permuted too in Comsol, but it is not yet tested
%% pyramid
pyr = INT_initElement('pyr','Pyramid',5,3,{'gmsh',7,'comsol','pyr'});
pyr.permutation.comsol = full(sparse(1:5,[1,3,4,2,5],ones(1,5)));
%% second order elements
edg2 = INT_initElement('edg2','Second order edge',3,1,{'gmsh',8});
tri2 = INT_initElement('tri2','Second order triangle',6,2,{'gmsh',9});
tet2 = INT_initElement('tet2','Second order tetrahedron',10,3,{'gmsh',11});

%% order here really doesn't matter when all are gathered together
this.reader = {vtx,edg,tri,quad,tet,hex,pri,pyr,edg2,tri2,tet2};    
end

function elem = INT_initElement(name,desc,vert,dim,types)
elem.name = name;
elem.description = desc;
elem.vertices = vert;
elem.dim = dim;
for k=1:2:length(types)
   elem.type.(types{k}) = types{k+1};
end
end

