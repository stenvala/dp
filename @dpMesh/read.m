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
while 1
    row = fgetl(fh);
    if strcmp(row,'$Nodes')
        break;
    end
end
% number of nodes
nmbNodes = str2num(fgetl(fh));
temp = fscanf(fh,'%f', 4*nmbNodes);
nodeData = reshape(temp,4,nmbNodes)';
% Read all coordinates from nodes and save as default
coords = nodeData(:,2:4);
blank = fgetl(fh); % Empty
if ~strcmp(blank,'$EndNodes')
    blank = fgetl(fh); % EndNodes
end
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
% Go through all the elements that are defined
for iElem = 1:nmbElems
    row = fgetl(fh);
    data = sscanf(row,'%d');
    elemNumber = data(1); % this is the element number
    type = data(2); % This type is used to distinguish different types of elements
    ind = this.reader.supportedTypes.gmsh.types == type;     
    if abs(sum(ind)-1) < 0.1;        
        elemType = this.reader.supportedTypes.names{ind};
        % find first unset element        
        nextInd = find(isnan(this.msh.(elemType).nums),1);
        this.msh.(elemType).nums(nextInd) = elemNumber;
        this.msh.(elemType).tags(nextInd) = data(4);        
        this.msh.(elemType).elems(nextInd,:) = data((end-this.reader.supportedTypes.vertices(ind)+1):end)';
    else                
        error(['Error in mesh file. Unknown element type: ' num2str(type) '.']);
    end
end
this.setRemoveNaNElems();
this.setRemoveUnusedElementEntities();
props.description = 'msh file coordinates';
props.name = 'gmsh';
this.setCoordinates(coords,'properties',props);
this.time.readMesh = toc;
end