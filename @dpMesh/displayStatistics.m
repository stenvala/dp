function displayStatistics(this,varargin)
% Display statistics of the mesh.
%
% varargin:
%   - basic {0}: don't show statistics by element type
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

defaults.basic = 0;
param = setDefaultParameters(defaults,varargin);

str = '---------------------';

disp(str);
disp('Statistics');
disp(str);
c = this.getCoordinates();
disp(['Dimension: ' num2str(this.dim)]);
disp(['Nodes: ' num2str(size(c,1))]);
disp(str);
disp('Elements');
f = fields(this.msh);
for k=1:length(f)
    tags = this.getElementTags(f{k});
    disp([f{k} ': ' num2str(length(tags))]);
   if ~param.basic         
       uTags = unique(tags);       
       for p=uTags'           
          disp([num2str(p) ': ' num2str(sum(p == tags))]);
       end       
   end    
end
disp(str);
