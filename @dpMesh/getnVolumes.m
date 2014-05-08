%% getnVolumes.m
%
% return n-volume of given element entity
%
% Created: Antti Stenvall (antti@stenvall.fi)

function v = getnVolumes(this, elementEntity)

try
    v = this.msh.(elementEntity).nvol;
catch e
    exception = MException('SetError:RequestedDataNotSet', ...
        'Either a) n-volumes are not computed for this element type or b) the computation is not implemented');
    throw(exception);
end