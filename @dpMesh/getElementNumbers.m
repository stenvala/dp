%% getElementNumbers.m
%
% Created: Antti Stenvall (antti@stenvall.fi)

function v = getElementNumbers(this,elementEntity)

try
    v = this.msh.(elementEntity).nums;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elementEntity ' are not initialized']);
    throw(exception);
end

end