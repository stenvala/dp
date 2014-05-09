%% getNumberOfElements.m
%
% get number of elements
%
% Created: Antti Stenvall (antti@stenvall.fi)

function s = getNumberOfElements(this,elementTypes)

if nargin < 2
    elementTypes = this.reader.supportedTypes.names;
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