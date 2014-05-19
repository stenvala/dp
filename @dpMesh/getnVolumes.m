function v = getnVolumes(this, elementEntity)
% Return n-volume of given element entity.
%
% parameters:
%   - elementEntity: short name for element
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

try
    v = this.msh.(elementEntity).nvol;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        'Either a) n-volumes are not computed for this element type or b) the computation is not implemented');
    throw(exception);
end
