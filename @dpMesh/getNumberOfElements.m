function s = getNumberOfElements(this,elementTypes)
% Get number of elements
%
% parameters:
%   - elemType {all possible}: short name for element (string or cell)
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

names = cellfun(@(x) x.name, this.reader,'UniformOutput',false);
if nargin < 2
    elementTypes = names;
elseif ~iscell(elementTypes)
    elementTypes = {elementTypes};
end

s = 0;

for k=1:length(elementTypes)
    if any(strcmp(names,elementTypes{k}))
       if isfield(this.msh,elementTypes{k})
          s = s + size(this.msh.(elementTypes{k}).tags,1);
       end        
    end    
end