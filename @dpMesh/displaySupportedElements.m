function displaySupportedElements(this,varargin)
% Display data related to elements that are supported.
%
% varargin:
%   - dim {0:3}: for which dimension(s) to display
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

defaults.dim = 0:3;
param = setDefaultParameters(defaults,varargin);

str = '---------------------';

disp(str);
cprintf('*black','dpMesh supports following element types\n');
disp(str);

for k=param.dim
   cprintf('blue','Elements with dimension ');
   cprintf('*Blue',[num2str(k) '\n']);
   ind = find(this.reader.supportedTypes.dimension == k);
   for p=ind
       cprintf('red',['  ' this.reader.supportedTypes.descriptions{p} '\n']);
       cprintf('black','    name: ');
       cprintf('*magenta',[this.reader.supportedTypes.names{p} '\n']);
       cprintf('black','    number of vertices: ');
       cprintf('*magenta',[num2str(this.reader.supportedTypes.vertices(p)) '\n']);
   end   
   disp(str);
end
