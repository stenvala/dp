function setRemoveElementEntities(this,elemType,tags)
% Remove some element types (possibly only those having some tag)
%
% parameters:
%   - elemType: element type (string or cell) to be removed
%   - tags {all}: which tags to remove
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

if iscell(elemType)
    for k=1:length(elemType)
        if nargin < 3
            this.setRemoveElementEntities(elemType{k});
        else
            this.setRemoveElementEntities(elemType{k},tags);
        end
    end
    return        
end

if nargin < 3
    this.msh = rmfield(this.msh,elemType);
else
    for k=1:length(tags)        
        this.msh.(elemType).tags(this.msh.(elemType).tags == tags(k)) = nan;
    end
    this.setRemoveNaNelems();
end

end
