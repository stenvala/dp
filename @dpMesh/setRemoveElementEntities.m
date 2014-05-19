function setRemoveElementEntities(this,elemEntity,tags)
% Remove some element types (possibly only those having some tag)
%
% parameters:
%   - elemEntity: element type (string or cell) to be removed
%   - tags {all}: which tags to remove
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

if iscell(elemEntity)
    for k=1:length(elemEntity)
        if nargin < 3
            this.setRemoveElementEntities(elemEntity{k});
        else
            this.setRemoveElementEntities(elemEntity{k},tags);
        end
    end
    return        
end

if nargin < 3
    this.msh = rmfield(this.msh,elemEntity);
else
    for k=1:length(tags)        
        this.msh.(elemEntity).tags(this.msh.(elemEntity).tags == tags(k)) = nan;
    end
    this.setRemoveNaNelems();
end

end
