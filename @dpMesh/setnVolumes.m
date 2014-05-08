%% setnVolumes.m
%
% compute lengths, surface areas and volumes to element entities in
% Cartesian metric
%
% Supports currently following element entities:
%   - tri
%
% save to this.msh.(elementEntity).nvol the n-volume of the n-element
% 
% Created: Antti Stenvall (antti@stenvall.fi)

function setnVolumes(this)

c = this.getCoordinates();

% tri
if isfield(this.msh,'tri') && size(this.msh.tri.elems,1) > 0
    t = this.msh.tri.elems;
    inode = c(t(:,1),:);
    jnode = c(t(:,2),:); 
    knode = c(t(:,3),:);
    this.msh.tri.nvol = 0.5*abs((jnode(:,1)-inode(:,1)).*(knode(:,2)-inode(:,2))-...
    (jnode(:,2)-inode(:,2)).*(knode(:,1)-inode(:,1)));
end


    