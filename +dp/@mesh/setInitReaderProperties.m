function setInitReaderProperties(this)
  % Init reader properties, for example element permutations and supported types
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  % gather all information of element types
  %% vertex
  vtx = intInitElement('vtx','Node or verted',1,0,nan,{'gmsh',15,'comsol','vtx'});
  %% edge
  edg = intInitElement('edg','Edge',2,1,'vtx',{'gmsh',1,'comsol','edg'});
  %% triangle
  tri = intInitElement('tri','Triangle',3,2,'edg',{'gmsh',2,'comsol','tri'});
  %% quadrangle
  quad = intInitElement('quad','Quadrangle',4,2,'edg',{'gmsh',3,'comsol','quad'});
  % add permutation for element order change (optional)
  quad.permutation.comsol = full(sparse(1:4,[1,3,4,2],ones(1,4)));
  %% tetrahedron
  tet = intInitElement('tet','Tetrahedron',4,3,'tri',{'gmsh',4,'comsol','tet'});
  %% hexahedron
  hex = intInitElement('hex','Hexahedron',8,3,'quad',{'gmsh',5,'comsol','hex'});
  hex.permutation.comsol = full(sparse(1:8,[1,3,4,2,5,7,8,6],ones(1,8)));
  %% prism
  pri = intInitElement('pri','Prism',6,3,{'tri','quad'},{'gmsh',6,'comsol','pri'});
  % most likely prism needs to be permuted too in Comsol, but it is not yet tested
  %% pyramid
  pyr = intInitElement('pyr','Pyramid',5,3,{'tri','quad'},{'gmsh',7,'comsol','pyr'});
  pyr.permutation.comsol = full(sparse(1:5,[1,3,4,2,5],ones(1,5)));
  %% second order elements
  edg2 = intInitElement('edg2','Second order edge',3,1,'vtx',{'gmsh',8});
  tri2 = intInitElement('tri2','Second order triangle',6,2,'edg2',{'gmsh',9});
  tet2 = intInitElement('tet2','Second order tetrahedron',10,3,'tri2',{'gmsh',11});
  %% third order elements
  edg3 = intInitElement('edg3','Third order edge',4,1,'vtx',{'gmsh',26});
  tri3 = intInitElement('tri3','Third order triangle',10,2,'edg3',{'gmsh',21});
  %% four order elements
  edg4 = intInitElement('edg4','Fourth order edge',5,1,'vtx',{'gmsh',27});
  tri4 = intInitElement('tri4','Fourth order triangle',15,2,'edg4',{'gmsh',23});
  %% order here really doesn't matter when all are gathered together
  this.reader = {vtx,edg,tri,quad,tet,hex,pri,pyr,edg2,tri2,tet2,edg3,tri3,edg4,tri4};
end

function elem = intInitElement(name,desc,vert,dim,bnd,types)
  elem.name = name;
  elem.description = desc;
  elem.vertices = vert;
  elem.dim = dim;
  elem.bnd = bnd;
  for k=1:2:length(types)
    elem.type.(types{k}) = types{k+1};
  end
end

