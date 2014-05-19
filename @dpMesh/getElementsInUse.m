function c = getElementsInUse(this,dim)
% Get all elements that are used.
%
% parameters:
%   - dim {all}: dimension (int) for which element types are returned
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

c = {};

for k=1:length(this.reader.supportedTypes.names)
   if nargin > 1 && ~isempty(dim) && ~any(dim == this.reader.supportedTypes.dimension(k))
       continue
   end    
   if isfield(this.msh,this.reader.supportedTypes.names{k}) && ...
           size(this.msh.(this.reader.supportedTypes.names{k}).elems,1) > 0       
      c{length(c)+1} = this.reader.supportedTypes.names{k};
   end    
end

end
