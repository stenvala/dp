function m = getCoordinatesAtElementCenter(this,elementEntity)
% Get coordinates at element centers
%
% parameters:
%   - elementEntity: element short name
% 
% Created: Antti Stenvall (antti@stenvall.fi)
%

c = this.getCoordinates();
e = this.msh.(elementEntity).elems;
elems = size(e,1);
nodes = size(e,2);
m = [mean(reshape(c(e,1),elems,nodes),2) ...
    mean(reshape(c(e,2),elems,nodes),2) ...
    mean(reshape(c(e,3),elems,nodes),2)];
end
