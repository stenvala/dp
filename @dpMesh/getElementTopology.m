function v = getElementTopology(this,elemType)
% Get element topology in terms of defined nodes.
%
% parameters:
%   - elemType: short name for element
%
% Created: Antti Stenvall (antti@stenvall.fi)

try
    v = this.msh.(elemType).elems;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elemType ' are not initialized']);
    throw(exception);
end

end