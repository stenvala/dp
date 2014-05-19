function v = getElementNumbers(this,elemType)
% Get numbers of elements. Each element has an unique number.
%
% parameters:
%   - elemType: short name for element
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

try
    v = this.msh.(elemType).nums;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elemType ' are not initialized']);
    throw(exception);
end

end