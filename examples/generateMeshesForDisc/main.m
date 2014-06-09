% Create mesh for round conductor
clear all, close all, clc;

r = 1e-3; % radius

for elementLayers = [2:15 20 40 50]
  close all;
  rE = elementLayers;
  points = linspace(-r,r,rE*2+1);
  
  coords = zeros(length(points)^2,3);
  
  for k=1:length(points)
    for p=1:length(points)
      coords((k-1)*length(points)+p,1:2) = [points(k) points(p)];
    end
  end
  
  % lets do rectangles
  rect = zeros((length(points)-1)^2,4);
  for k=1:(length(points)-1)
    for p=1:(length(points)-1)
      rect((k-1)*(length(points)-1)+p,:) = [(k-1)*(length(points))+p (k-1)*(length(points))+p+1 ...
        k*(length(points))+p+1 k*(length(points))+p];
    end
  end
  
  rectTags = 2*ones(size(rect,1),1);
  rectNums = 1:size(rect,1);
  
  
  fun = @(xyz) sqrt(xyz(:,1).^2+xyz(:,2).^2) > r;
  
  msh = dpMesh();
  msh.setCoordinates(coords);
  msh.setElem('quad',rect,2001*ones(size(rect,1),1),(1:size(rect,1))');
  msh.setTagsChangeByCoordFun(1,fun,'quad');
  msh.setRemoveElementEntities('quad',1);
  msh.setRemoveDuplicateCoordinates();
  msh.setRemoveUnusedNodes();
  %coords = msh.getCoordinates();
  %rect = msh.getMesh().quad.elems;
  
  ch = msh.getBoundaryOfElementGroup('quad',2001);
  msh.setElem('edg',ch,1001*ones(size(ch,1),1),size(rect,1)+(1:size(ch,1))');
  
  msh.plot2d('figure',1);
  hold on
  theta = linspace(0,2*pi);
  plot(r*cos(theta),r*sin(theta),'k','linewidth',2);
  hold off
  axis equal
  msh.setRemoveElementEntities('edg');
  msh.setResetElementNumbering();
  msh.write('fileName',[pwd '/quad-regular-' num2str(elementLayers) '.msh']);
  saveas(gcf,['quad-regular-' num2str(elementLayers) '.png']);
  % make another mesh from triangles
  tri = zeros(2*size(rect,1),3);
  for k=1:size(rect,1)
    cx = mean(coords(rect(k,:),1));
    cy = mean(coords(rect(k,:),2));
    if cx < 0 && cy < 0 || cx > 0 && cy > 0
      tri(k,:) = rect(k,[2 3 4]);
      tri(k+size(rect,1),:) = rect(k,[1 2 4]);
    else
      tri(k,:) = rect(k,[1 2 3]);
      tri(k+size(rect,1),:) = rect(k,[1 3 4]);
    end
  end
  
  msh2 = dpMesh();
  msh2.setCoordinates(coords);
  msh2.setElem('tri',tri,2001*ones(size(tri,1),1),(1:size(tri,1))');
  msh2.setTagsChangeByCoordFun(1,fun,'tri');
  msh2.setRemoveElementEntities('tri',1);
  edges = msh2.getBoundaryOfElementGroup('tri',2001); 
  tri = msh2.getMesh().tri.elems;
  msh2.setElem('edg',edges,1001*ones(size(edges,1),1),size(tri,1)+(1:size(edges,1))');
  msh2.plot2d('figure',2,'offsetx',15);
  hold on
  theta = linspace(0,2*pi);
  plot(r*cos(theta),r*sin(theta),'k','linewidth',2);
  hold off
  axis equal
  msh2.setRemoveElementEntities('edg');
  msh2.setResetElementNumbering();
  msh2.write('fileName',[pwd '/tri-regular-' num2str(elementLayers) '.msh']);
  saveas(gcf,['tri-regular-' num2str(elementLayers) '.png']);
end

