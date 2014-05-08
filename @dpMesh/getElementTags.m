%% getElementTags.m
%
% Created: Antti Stenvall (antti@stenvall.fi)

function v = getElementTags(this,elementEntity)

try
    v = this.msh.(elementEntity).tags;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elementEntity ' are not initialized']);
    throw(exception);
end

end