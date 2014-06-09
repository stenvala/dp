% Create mesh for round conductor

clear all, close all, clc;
r = 1e-3; % radius of the disc
% convert many meshes simultaneously. Define here how many edge elements are
% added to one quarter of the disc perimeter when the disc is represented
% with triangles
for elementLayers = [2:15 20 40 50]
  close all
  clc
  
  coords = zeros(0,3);
  rect = zeros(0,4);
  angle = linspace(0,pi/2,elementLayers+1);

  % this is a bit dummy because it results in duplicate nodes! however,
  % this way everything is easier
  for k=1:(length(angle)-1)
    xstart = r*cos(angle(k));
    xend = r*cos(angle(k+1));
    ystart = r*sin(angle(k));
    yend = r*sin(angle(k+1));
    coords(end+1,:) = [xstart ystart 0];
    coords(end+1,:) = [xstart yend 0];
    coords(end+1,:) = [xend ystart 0];
    coords(end+1,:) = [xend yend 0];
    cs = size(coords,1);
    rect(end+1,:) = [cs-3 cs-2 cs cs-1];
    for p=k:(length(angle)-2);
      xend = r*cos(angle(p+2));
      xstart = r*cos(angle(p+1));
      coords(end+1,:) = [xstart ystart 0];
      coords(end+1,:) = [xstart yend 0];
      coords(end+1,:) = [xend ystart 0];
      coords(end+1,:) = [xend yend 0];
      cs = size(coords,1);
      rect(end+1,:) = [cs-3 cs-2 cs cs-1];
    end
  end
  
  % then map all the elements to different position
  nodeNum = size(coords,1);
  coords = [coords;
    coords*diag([-1 1 1]);
    coords*diag([-1 -1 1]);
    coords*diag([1 -1 1])];
  coords(abs(coords) < r*1e-5) = 0; % this removes the problem of some duplicate nodes
  rect = [rect;
    rect*[0 0 0 1;0 0 1 0;0 1 0 0; 1 0 0 0]+nodeNum;
    rect*[0 0 1 0;0 0 0 1;1 0 0 0; 0 1 0 0]+nodeNum*2;
    rect*[0 1 0 0;1 0 0 0;0 0 0 1; 0 0 1 0]+nodeNum*3];
    
  fun = @(xyz) sqrt(xyz(:,1).^2+xyz(:,2).^2) > r;
  msh = dpMesh('quad');
  msh.setCoordinates(coords);
  msh.setElem('quad',rect,2001*ones(size(rect,1),1),(1:size(rect,1))');
  msh.setRemoveDuplicateCoordinates();
  coords = msh.getCoordinates();  
  rect = msh.getMesh().quad.elems;
  %ch = msh.getConvexHull('quad',2001);
  ch = msh.getBoundaryOfElementGroup('quad',2001);
  msh.setElem('edg',ch,1001*ones(size(ch,1),1),size(rect,1)+(1:size(ch,1))');
  msh.setTagsChangeByCoordFun(1,fun,'quad');
  msh.setRemoveElementEntities('quad',1);
  msh.plot2d('figure',1,'height',10,'width',10);
  hold on
  theta = linspace(0,2*pi);
  plot(r*cos(theta),r*sin(theta),'k','linewidth',2);
  msh.plotPhysicalDomains1d('figure',0,'colors',{'r'},'lineWidth',2);
  hold off
  axis equal
  saveas(gcf,['quad-' num2str(elementLayers) '.png']);
  msh.setRemoveElementEntities('edg')
  msh.setResetElementNumbering();
  msh.write('fileName',[pwd '/quad-' num2str(elementLayers) '.msh']);  
  % make another where elements that have even one node outside don't
  % belong to this
  fun2 = @(xyz) sqrt(xyz(:,1).^2+xyz(:,2).^2) > (r+1e-10);
  msh.setTagsChangeByCoordFunAnyNode(1,fun2,'quad');
  msh.setRemoveElementEntities('quad',1);
  msh.setRemoveElementEntities('edg',1001);
  ch = msh.getBoundaryOfElementGroup('quad',2001);
  msh.setElem('edg',ch,1001*ones(size(ch,1),1),nan);    
  msh.plot2d('figure',3,'height',10,'width',10,'offsetx',25);
  hold on
  theta = linspace(0,2*pi);
  plot(r*cos(theta),r*sin(theta),'k','linewidth',2);
  msh.plotPhysicalDomains1d('figure',0,'colors',{'r'},'lineWidth',2);
  hold off
  axis equal
  saveas(gcf,['quad-internal-' num2str(elementLayers) '.png']);
  msh.setRemoveElementEntities('edg');
  msh.setResetElementNumbering();
  msh.write('fileName',[pwd '/quad-internal-' num2str(elementLayers) '.msh']);    
  % make another mesh from triangles
  tri = zeros(2*size(rect,1),3);
  for k=1:size(rect,1)
    cx = mean(coords(rect(k,:),1));
    cy = mean(coords(rect(k,:),2));
    if cx < 0 && cy > 0 || cx > 0 && cy < 0
      tri(k,:) = rect(k,[2 3 4]);
      tri(k+size(rect,1),:) = rect(k,[1 2 4]);
    else
      tri(k,:) = rect(k,[1 2 3]);
      tri(k+size(rect,1),:) = rect(k,[1 3 4]);
    end
  end
  
  msh2 = dpMesh('tri');
  msh2.setCoordinates(coords);
  msh2.setElem('tri',tri,2001*ones(size(tri,1),1),(1:size(tri,1))');
  msh2.setTagsChangeByCoordFun(1,fun,'tri');
  msh2.setRemoveElementEntities('tri',1);
  msh2.plot2d('figure',2,'offsetx',45,'height',10,'width',10);
  edges = msh2.getBoundaryOfElementGroup('tri',2001);
  % Add also edge to the representation
  msh2.setElem('edg',edges,1001*ones(size(edges,1),1),size(tri,1)+(1:size(edges,1))');
  hold on  
  theta = linspace(0,2*pi);
  plot(r*cos(theta),r*sin(theta),'k','linewidth',2);
  msh2.plotPhysicalDomains1d('figure',0,'colors',{'r'},'lineWidth',2);
  hold off
  axis equal
  saveas(gcf,['tri-' num2str(elementLayers) '.png']);
  msh2.setRemoveElementEntities('edg');
  msh2.setResetElementNumbering();
  msh2.write('fileName',[pwd '/tri-' num2str(elementLayers) '.msh']);
end