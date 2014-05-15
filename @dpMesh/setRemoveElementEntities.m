%% setRemoveElementEntities.m
%
% remove some element types (possibly only those having some tag)
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setRemoveElementEntities(this,elemEntity,tags)

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