%% Post-processing script to return 2
%
% You are not allowed to change the definitions of the function calls.
%
% Created: Antti Stenvall (antti@stenvall.fi)
% Contributed:
%

close all;
clc;

%% Find out element type
elementType = msh.getSimplexElementType();
el = msh.getElementTopology(elementType);
coords = msh.getCoordinates();
xlim = [0 0.3];
ylim = [0 0.2];

%% potential displayed similarly as before
common.fig('figure',1,'height',12,'width',16)
trisurf(el(:,1:3),...
  coords(:,1),...
  coords(:,2),...
  prob.getSolutionAtNodes(),...
  'edgecolor','none','facecolor','interp');
common.figAdjust('xlim',xlim,'ylim',ylim,'axis','equal','view',[0 90]);
saveas(gcf,'figSolution.png');

%% post-processor object
ppr = dp.postProcess('problem',prob,'msh',msh);

%% plot norm of gradient
ppr.plotNormOfGradientOfNodalBasisFunctions(prob.getSolutionAtNodes(),...
  elementType,'figure',2,'xlim',xlim,'ylim',ylim,'axis','equal','height',12,'width',16);
saveas(gcf,'figNormGrad.png');

%% quiver plot of gradient
xspace = linspace(1e-4,0.3,15);
yspace = linspace(1e-4,0.2,15);
common.fig('figure',3,'height',12,'width',16);
msh.plot2d('figure',0,'xlim',xlim,'ylim',ylim,'axis','equal','tags',[2001 2002],'colors',[0.8 0.8 0.8]);
hold on
ppr.plotGradientOfNodalBasisFunctions(prob.getSolutionAtNodes(),...
  elementType,...
  'color','r',...
  'figure',0,...
  'quiver',{'r','linewidth',0.5,'maxheadsize',1},...
  'xgrid',xspace,'ygrid',yspace);
hold off
saveas(gcf,'figGrad.png');

%% inductance computation
elementTags = msh.getMesh().(elementType).tags;
% note, we add new material property for his, because the material
% properties were scaled for the solution, display also energy (no ;)
energy = prob.getTotalEnergy('labels',domain.labels,'material',domain.nu) 
% and you should do the rest to find out the inductance in [H/m]

% finally display inductance
inductance