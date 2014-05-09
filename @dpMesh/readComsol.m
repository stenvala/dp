%% readComsol.m
%
% read Comsol .mphtxt file into dp mesh structure
%
% Created: Antti Stenvall (antti@stenvall.fi)

function readComsol(this,varargin)

defaults.fileName = [this.project '.mphtxt'];
defaults.directory = pwd;
param = setDefaultParameters(defaults,varargin);

tic
%% open file
f = fopen(fullfile(param.directory,param.fileName), 'rt');
lin = readUntilReached(f,' # number of mesh points');

coords = zeros(getNumFromLine(lin),3);

readUntilReached(f,'# Mesh point coordinates');
if this.dim == 3
    coords = fscanf(f, '%g %g %g', [3,size(coords,1)])';
elseif this.dim == 2
    coords(:,1:2) = fscanf(f, '%g %g', [2,size(coords,1)])';
else
    error('Sorry, cannot read 1-D meshes');
end

props.description = 'mphtxt file coordinates';
props.name = 'comsol';
this.setCoordinates(coords,'properties',props);
%% read elements
numElem = 0;
while 1
    lin = readUntilReached(f,' # type name');
    if ~ischar(lin)
        break;
    end
    type = getElementType(lin);
    if ~isSupportedType(type,this.reader.supportedTypes.comsol.names)
        disp(['Cannot read elements of type ' type '. This element type is not supported.']);
        continue;
    end
    numOfVertices = getNumOfVertices(type,this.reader.supportedTypes.names,this.reader.supportedTypes.vertices);
    lin = readUntilReached(f,' # number of elements');
    numOfElem = getNumFromLine(lin);
    readUntilReached(f,'# Elements');
    % elements 
    if isfield(this.reader.comsol.permutation,type)
        perm = this.reader.comsol.permutation.(type);
    else
        perm = eye(numOfVertices);
    end        
    this.msh.(type).elems = (perm*(1+fscanf(f, getScanStr(numOfVertices), [numOfVertices,numOfElem])))';
    readUntilReached(f,'# Geometric entity indices');
    this.msh.(type).tags = fscanf(f, '%d', [1,numOfElem])';    
    this.msh.(type).nums = (numElem+(1:numOfElem))';
    numElem = numElem + numOfElem;
end
%% finish reading
fclose(f);

end

%% HELP FUNCTIONS

function type = getElementType(line)
inds = strfind(line,' ');
type = strtrim(line(inds(1):inds(2)));
end

function num = getNumFromLine(line)
num = str2double(line(1:(strfind(line,' '))));
end

function int = getNumOfVertices(type,supportedTypes,supportedTypesVertices)
ind = find(strcmp(supportedTypes,type));
int = supportedTypesVertices(ind);
end

function str = getScanStr(numOfElem)
str = '';
for k=1:numOfElem
    str = [str '%d '];
end
str = strtrim(str);
end

function bool = isSupportedType(type,supportedTypes)
if any(strcmp(supportedTypes,type))
    bool = 1;
else
    bool = 0;
end
end

function line = readUntilReached(fileHandle,str)
while 1    
    line = fgetl(fileHandle);    
    if ~ischar(line)
        % file end reached
        % warning('String not found from the line');
        return
    end
    if strfind(line,str);
        return;
    end
end
end