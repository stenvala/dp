function m = getBoundaryOfElementGroup(this,elemType,tag)
  % Returns the boundary of element group (works currently only for 2-D
  % domains)
  %
  % parameters:
  %   - elemType: type of element for which the boundary is searched
  %   - tag: element group tag
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  tags = this.msh.(elemType).tags;
  elem = this.msh.(elemType).elems(tags == tag,:);
  
  c = this.getCoordinates();
  if strcmp(elemType,'tri')
    TR = triangulation(elem,c(:,1),c(:,2));
    m = freeBoundary(TR);
  elseif strcmp(elemType,'quad')
    nodes = unique(elem(:));
    x = c(:,1);
    y = c(:,2);
    [~, ind] = sort(x(nodes));
    nodes = nodes(ind);
    bnd = nodes(1);
    % upper part
    tol = 1e-10;
    for k=2:length(nodes)
      % find first if this is some boundary      
      if sum(elem(:) == nodes(k)) < 4       
        bnd(end+1) = nodes(k);
      end            
    end            
    % works only approximately
    m = zeros(size(bnd));
    m(1) = bnd(1);
    length(bnd)    
    indLeft = 2:length(bnd);
    for k=2:length(bnd)
        dist = (x(m(k-1))-x(bnd(indLeft))).^2+(y(m(k-1))-y(bnd(indLeft))).^2;
        ind = find(dist == min(dist),1);
        m(k) = bnd(indLeft(ind));        
        indLeft = setdiff(indLeft,indLeft(ind));        
    end            
    m = [m(1:end)' [m(2:end) m(1)]'];        
  else
    error(['Method not implemented for element type ' elemType]);
  end
  
end


function vertices = INT_convexHull(p,x,y)
  Lupper = [p(1) p(2)];
  for k=3:length(p)
    Lupper(end+1) = p(k);
    while length(Lupper) > 2 && ...
        ~INT_isRightTurn(Lupper(end-2:end),x,y)
      Lupper = [Lupper(1:end-2) Lupper(end)];
    end
  end
  Llower = Lupper(end:-1:end-1);
  for k=(length(p)-2):-1:1
    Llower(end+1) = p(k);
    while length(Llower) > 2 && ...
        ~INT_isRightTurn(Llower(end-2:end),x,y)
      Llower = [Llower(1:end-2) Llower(end)];
    end
  end
  Llower = Llower(2:(end-1));
  vertices = [Llower Lupper]';
end

function bool = INT_isRightTurn(p3,x,y)
  tol = 1e-10;
  if abs(x(p3(1))-x(p3(3))) < tol;
    if abs(x(p3(2))-x(p3(3))) < tol;
      bool = 1;
    elseif x(p3(1)) > x(p3(2))
      bool = 0;
    else
      bool = 1;
    end
  elseif x(p3(1)) == x(p3(2))
    if x(p3(1)) < x(p3(3))
      bool = 1;
    else
      bool = 0;
    end
  else
    p1 = polyfit(x(p3([1 2])),y(p3([1 2])),1);
    p2 = polyfit(x(p3([1 3])),y(p3([1 3])),1);
    if p1(1) > p2(1)
      bool = 1;
    else
      bool = 0;
    end
  end
end
