%% getElementTopology.m
%
% Created: Antti Stenvall (antti@stenvall.fi)

function v = getElementTopology(this,elementEntity)

try
    v = this.msh.(elementEntity).elems;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elementEntity ' are not initialized']);
    throw(exception);
end

end