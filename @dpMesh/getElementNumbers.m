function v = getElementNumbers(this,elementEntity)
% Get numbers of elements. Each element has an unique number.
%
% parameters:
%   - elementEntity: short name for element
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

try
    v = this.msh.(elementEntity).nums;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elementEntity ' are not initialized']);
    throw(exception);
end

end