%% Post-processing script to return 2
%
% You are allowed to change the definitions of the function calls etc. This
% is merely an example.
%
% Created: Antti Stenvall (antti@stenvall.fi)
% Contributed:
%

close all;
clc;

%% Find out element type
switch elementOrder
  case 1
    elementType = 'tri';
  case 2
    elementType = 'tri2';
  case 3
    elementType = 'tri3';
  case 4
    elementType = 'tri4';
end

el = msh.getElementTopology(elementType);
coords = msh.getCoordinates();
xlim = [0 0.3];
ylim = [0 0.2];

%% potential displayed similarly as before
fig('figure',1,'height',12,'width',16)
trisurf(el(:,1:3),...
  coords(:,1),...
  coords(:,2),...
  prob.getLaplaceSolutionAtNodes(),...
  'edgecolor','none','facecolor','interp');
figAdjust('xlim',xlim,'ylim',ylim,'axis','equal','view',[0 90]);
saveas(gcf,'figSolution.png');

%% post-processor object
pp = dpPostProcess('problem',prob,'msh',msh);

%% plot norm of gradient
pp.plotNormOfGradientOfNodalBasisFunctions(prob.getLaplaceSolutionAtNodes(),...
  elementType,'figure',2,'xlim',xlim,'ylim',ylim,'axis','equal','height',12,'width',16);
saveas(gcf,'figNormGrad.png');

%% quiver plot of gradient
xspace = linspace(1e-4,0.3,15);
yspace = linspace(1e-4,0.2,15);
fig('figure',3,'height',12,'width',16);
msh.plot2d('figure',0,'xlim',xlim,'ylim',ylim,'axis','equal','tags',[2001 2002],'colors',[0.8 0.8 0.8]);
hold on
pp.plotGradientOfNodalBasisFunctions(prob.getLaplaceSolutionAtNodes(),...
  elementType,...
  'color','r',...
  'figure',0,...
  'quiver',{'r','linewidth',0.5,'maxheadsize',1},...
  'xgrid',xspace,'ygrid',yspace);
hold off
saveas(gcf,'figGrad.png');

%% inductance computation
elementTags = msh.getMesh().(elementType).tags;
matPro = prob.getDomainPropertyVector(elementTags,domain.labels,domain.nu);
energy = dpPostProcess.integrateEnergyBasedOnNodalValues(msh,prob.getLaplaceSolutionAtNodes(),...
  elementType,matPro);
% and you should do the rest to find out the inductance in [H/m]