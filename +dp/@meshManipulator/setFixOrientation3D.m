function setFixOrientation3D(this, varargin)
  % Fixes orientation of 3D elements to right handed, now works only for
  % tetrahedra
  %
  % Created: Antti Stenvall (antti@stenvall.fi)

  elems = this.getMesh().tet.elems;
  cc = this.getCoordinates();
   
  % todo vectorize this
  for k=1:size(elems,1)    
    e = elems(k,:);
    a = cc(e(2),:)-cc(e(1),:);
    b = cc(e(3),:)-cc(e(1),:);
    c = cc(e(4),:)-cc(e(1),:);    
    if det([a;b;c]) < 0      
      % permute nodes        
      elems(k,:) = [e(1) e(3) e(2) e(4)];
    end    
  end
  
  m = this.getMesh();
  this.setElem('tet',elems,m.tet.tags,m.tet.nums);
