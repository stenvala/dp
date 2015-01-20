function setFixBoundaryOrientation3D(this, varargin)
  % Fixes outer surface orientation in 3D so that it will always result in outer pointing normal
  % This is a bit dummy and under construction for a specific task in a
  % project. Doesn't really do what promises / should do
  %
  % varargin:
  %   - inOrOut {1}: if inner (-1) or outer (1) normals should result from the
  %   cross-product of the edge vectors
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  
  defaults.inOrOut = 1;
  param = setDefaultParameters(defaults,varargin);
  
  elems = this.getMesh().tri.elems;
  cc = this.getCoordinates();
  
  cMat = zeros(size(elems));
  cCoord = cMat;
  
  %dt = TriRep(msh.getMesh().tet.elems,cc(:,1),cc(:,2),cc(:,3));
  % needs to do DelaynayTriangularization and estimate things with it
  dt = DelaunayTri(cc(:,1),cc(:,2),cc(:,3));
  % todo vectorize this
  for k=1:size(elems,1)
    e = elems(k,:);
    aa = cc(e(2),:)-cc(e(1),:);
    a = aa / norm(aa);
    bb = cc(e(3),:)-cc(e(1),:);
    c = cross(a,bb);
    b = bb-a*(a*bb');
    b = b/norm(b);
    c = c-a*(a*c')-b*(a*b');
    c = c/norm(c);
    cCoord(k,:) = [mean(cc(e,1)) mean(cc(e,2)) mean(cc(e,3))];
    % check if c is pointing inwards
    % some numerical tolerance errors needs to be utilized
    damp = mean([norm(aa) norm(bb)]);    
    p = cc(e(1),:)*0.98+...
      cc(e(2),:)*0.01+...
      cc(e(3),:)*0.01+...
      c*damp;
    ind = pointLocation(dt,p(1),p(2),p(3));
    if (isnan(ind) && param.inOrOut == -1) || ...
        (~isnan(ind) && param.inOrOut == 1)
      c = -c;
      % permute nodes
      elems(k,:) = [e(1) e(3) e(2)];
    end
    cMat(k,:) = c;
  end
  
  m = this.getMesh();
  this.setElem('tri',elems,m.tri.tags,m.tri.nums);
