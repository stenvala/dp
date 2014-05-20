function c = getElementsInUse(this,dim)
% Get all elements that are used.
%
% parameters:
%   - dim {all}: dimension (int) for which element types are returned
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

c = {};

for k=1:length(this.reader)
   if nargin > 1 && ~isempty(dim) && ~any(dim == this.reader{k}.dim)
       continue
   end    
   if isfield(this.msh,this.reader{k}.name) && ...
           size(this.msh.(this.reader{k}.name).elems,1) > 0       
      c{length(c)+1} = this.reader{k}.name;
   end    
end

end
