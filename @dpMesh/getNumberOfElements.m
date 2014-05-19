function s = getNumberOfElements(this,elementTypes)
% Get number of elements
%
% parameters:
%   - elemType {all possible}: short name for element (string or cell)
%
% Created: Antti Stenvall (antti@stenvall.fi)

if nargin < 2
    elementTypes = this.reader.supportedTypes.names;
elseif ~iscell(elementTypes)
    elementTypes = {elementTypes};
end

s = 0;

for k=1:length(elementTypes)
    if any(strcmp(this.reader.supportedTypes.names,...
            elementTypes{k}))
       if isfield(this.msh,elementTypes{k})
          s = s + size(this.msh.(elementTypes{k}).tags,1);
       end        
    end    
end