%% getElementTags.m
%
% returns element tags for element type or all existing tags for dimension
% (unique)
%
% Created: Antti Stenvall (antti@stenvall.fi)

function v = getElementTags(this,elementEntityOrDim)

if isnumeric(elementEntityOrDim)
    tags = [];
    for k=find(this.reader.supportedTypes.dimension == elementEntityOrDim)
        if isfield(this.msh,this.reader.supportedTypes.names{k})
           tags = [tags unique(this.msh.(this.reader.supportedTypes.names{k}).tags)]; 
        end
    end
    v = unique(tags);
    return
end

try
    v = this.msh.(elementEntityOrDim).tags;
catch e
    v = [];
    warning(['Requested tags for ' elementEntityOrDim ', but it does not exist']);        
end

end