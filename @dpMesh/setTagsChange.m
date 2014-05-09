%% setTagsChange.m
%
% tag changer: change number to another
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setTagsChange(this,from,to,elemType)
try
    for k=1:length(from)    
        this.msh.(elemType).tags(this.msh.(elemType).tags == from(k)) = to;    
    end
catch e
    exception = MException('SetError:RequestedElementTypeDoesNotExist', ...
        'Tried to modify tag of an unexisting element type.');
    throw(exception);
end
end