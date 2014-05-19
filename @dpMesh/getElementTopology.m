function v = getElementTopology(this,elementEntity)
% Get element topology in terms of defined nodes.
%
% parameters:
%   - elementEntity: short name for element
%
% Created: Antti Stenvall (antti@stenvall.fi)

try
    v = this.msh.(elementEntity).elems;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        ['Element entities ' elementEntity ' are not initialized']);
    throw(exception);
end

end