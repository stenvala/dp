function m = getConvexHull(this,elemType,tag)
  % Returns convex hull for a 2-d element group
  %
  % parameters:
  %   - elemType: type of element for which the hull is searched
  %   - tag: element group tag
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  tags = this.msh.(elemType).tags;
  elem = this.msh.(elemType).elems(tags == tag,:);
    
  % algorithm: de Berg, Cheong, van Kreveld, Overmars: Computational
  % Geometry, Springer, 2008, p. 6
  nodes = unique(elem(:));
  c = this.getCoordinates();  
  x = c(:,1);
  y = c(:,2);
  [~, ind] = sort(x(nodes));
  nodes = nodes(ind);
  vertices = INT_convexHull(nodes,x,y);
  m = [vertices(1:end) [vertices(2:end); vertices(1)]];
      
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
