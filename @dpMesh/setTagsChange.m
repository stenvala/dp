%% setTagsChange.m
%
% tag changer: change number to another
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setTagsChange(this,from,to,elemType)
if iscell(elemType)
   for k=1:length(elemType)
       this.setTagsChange(from,to,elemType{k});
   end
    return;
end

try
    for k=1:length(from)    
        this.msh.(elemType).tags(this.msh.(elemType).tags == from(k)) = to;    
    end
catch e    
    exception = MException('SetError:RequestedElementTypeDoesNotExist', ...
        ['Tried to modify tag of an unexisting element type: ' elemType]);
    throw(exception);
end
end