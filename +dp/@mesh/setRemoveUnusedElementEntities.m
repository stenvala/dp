%% setRemoveUnusedElementEntities.m
%
% initialize msh structure for all the possible element types
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

function setRemoveUnusedElementEntities(this)
  
  for k=1:length(this.reader)
    if isfield(this.msh,this.reader{k}.name) && ...
        size(this.msh.(this.reader{k}.name).elems,1) == 0
      this.msh = rmfield(this.msh,this.reader{k}.name);
    end
  end
end
