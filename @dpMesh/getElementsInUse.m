%% getElementsInUse.m
%
% return in cell array all the names of elements that are in use (i.e. at
% least one such element is defined, give dimension if elements having
% specific dimension are requested (this is optional, otherwise all the
% elements are returned)
%
% Created: Antti Stenvall (antti@stenvall.fi)

function c = getElementsInUse(this,dim)
inUse = {};

for k=1:length(this.reader.supportedTypes.names)
   if nargin > 1 && ~isempty(dim) && ~any(dim == this.reader.supportedTypes.dimension(k))
       continue
   end    
   if isfield(this.msh,this.reader.supportedTypes.names{k}) && ...
           size(this.msh.(this.reader.supportedTypes.names{k}).elems,1) > 0       
      inUse{length(inUse)+1} = this.reader.supportedTypes.names{k};
   end    
end

end