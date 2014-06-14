function setnVolumes(this)
  % Compute lengths, surface areas and volumes to element entities in Cartesian metric
  %
  % Saves to this.msh.(elemType).nvol the n-volume of the n-element
  % Supports currently following element entities:
  %   - tri
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
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
  % quad
  if isfield(this.msh,'quad') && size(this.msh.quad.elems,1) > 0    
    h = abs(c(this.msh.quad.elems(:,1),1)-c(this.msh.quad.elems(:,2),1));
    if sum(h) < 1e-10
      h = abs(c(this.msh.quad.elems(:,2),1)-c(this.msh.quad.elems(:,3),1));
    end
    w = abs(c(this.msh.quad.elems(:,2),2)-c(this.msh.quad.elems(:,3),2));
    if sum(w) < 1e-10
      w = abs(c(this.msh.quad.elems(:,1),2)-c(this.msh.quad.elems(:,2),2));
    end
    this.msh.quad.nvol = w.*h;
  end  
end
