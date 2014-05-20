function v = getElementTags(this,elemTypeOrDim)
% Return element tags of given dimension or type
%
% parameters:
%   - elemTypeOrDim: element short name (string) or dimension (int)
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

if isnumeric(elemTypeOrDim)
    tags = [];       
    for k=find(cellfun(@(x) x.dim == elemTypeOrDim, this.reader))
        if isfield(this.msh,this.reader{k}.name)
           tags = [tags; unique(this.msh.(this.reader{k}.name).tags)]; 
        end
    end
    v = unique(tags);    
    return
end

try
    v = this.msh.(elemTypeOrDim).tags;
catch e
    v = [];
    warning(['Requested tags for ' elemTypeOrDim ', but it does not exist']);        
end

end
