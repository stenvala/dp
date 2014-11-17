function read(this,varargin)
  % Read gmsh .msh file.
  %
  % varargin:
  %   - directory {working dir}: where the file is
  %   - fileName {this.project}: .msh file for reading
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.directory = pwd;
  defaults.fileName = this.project;
  param = setDefaultParameters(defaults,varargin);
  tic
  % Handle
  fh = fopen(fullfile(param.directory,[param.fileName '.msh']), 'rt');
  % Some lines not needed
  meshFormat = '';
  while 1
    row = fgetl(fh);
    if strcmp(row,'$MeshFormat')
      meshFormat = fgetl(fh);     
    end
    if strcmp(row,'$Nodes')
      break;
    end
  end
  if isempty(meshFormat)
    error('Could not read mesh file format');
  end
  
  switch (meshFormat)
    case {'2.2 0 8'}
      mf.coordNodes = 4;
    case {'3 0 8'}
      mf.coordNodes = 5;
    otherwise
      % hmm     
  end
  
  % number of nodes
  nmbNodes = str2num(fgetl(fh));
  temp = fscanf(fh,'%f', mf.coordNodes*nmbNodes);
  nodeData = reshape(temp,mf.coordNodes,nmbNodes)';
  % Read all coordinates from nodes and save as default
  coords = nodeData(:,2:4);
  blank = fgetl(fh); % Empty
  if ~strcmp(blank,'$EndNodes')
    blank = fgetl(fh); % EndNodes
  end
  blank
  size(coords)
  row = fgetl(fh); % Elements
  if ~strcmp(row,'$Elements')    
    error('MSH-file error !');
  end
  % Number of elements in file
  elem = fgetl(fh);
  nmbElems = str2num(elem);
  % Preallocate this amount of data for each element type
  % Preallocating too much does not take a lot of time, but if it is necessary to
  % allocate element by element it takes a lot of time
  this.setInitElementEntities(nmbElems);
  % set up a data structure for mapping gmsh elements
  map = cell(100,1);
  for k=1:length(this.reader)
    map{this.reader{k}.type.gmsh} = struct('name',this.reader{k}.name,...
      'vertices',this.reader{k}.vertices);
  end
  
  % Go through all the elements that are defined
  for iElem = 1:nmbElems
    row = fgetl(fh);
    data = sscanf(row,'%d');
    elemNumber = data(1); % this is the element number
    type = data(2); % This type is used to distinguish different types of elements
    if ~isempty(map{type});
      elemType = map{type}.name;
      % find first unset element
      nextInd = find(isnan(this.msh.(elemType).nums),1);
      this.msh.(elemType).nums(nextInd) = elemNumber;
      this.msh.(elemType).tags(nextInd) = data(4);
      this.msh.(elemType).elems(nextInd,:) = data((end-map{type}.vertices+1):end)';
    else
      error(['Error in mesh file. Unknown element type: ' num2str(type) '.']);
    end
  end
  
  fclose(fh);
  this.setRemoveNaNElems();
  this.setRemoveUnusedElementEntities();
  props.description = 'msh file coordinates';
  props.name = 'gmsh';
  this.setCoordinates(coords,'properties',props);
  this.time.readMesh = toc;
end