%% setRemoveUnusedElementEntities.m
%
% initialize msh structure for all the possible element types
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setRemoveUnusedElementEntities(this)

for k=1:length(this.reader.supportedTypes.names)
    if isfield(this.msh,this.reader.supportedTypes.names{k}) && ...
        size(this.msh.(this.reader.supportedTypes.names{k}).elems,1) == 0
        this.msh = rmfield(this.msh,this.reader.supportedTypes.names{k});
    end
end