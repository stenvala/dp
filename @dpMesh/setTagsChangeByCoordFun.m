function setTagsChangeByCoordFun(this,to,fun,elemType,from)
% Tag changer: change element tag when the center coordinate fulfils condition
%
% parameters:
%   - to 
%   - fun (takes in matrix n*3 of element center coordinates)
%   - elemType
%   - from {all elements}: you can only set to change from some
%
% Created: Antti Stenvall (antti@stenvall.fi)

if iscell(elemType)
   for k=1:length(elemType)
       if nargin > 4
            this.setTagsChange(to,fun,elemType{k},from);
       else
           this.setTagsChange(to,fun,elemType{k});
       end
   end
    return;
end

values = feval(fun,getCoordinatesAtElementCenter(this,elemType));

if nargin > 4 && ~isempty(from)
    elemsTrue = find(values);
    elems = [];
    from = unique(from);
    for k=1:length(from)
        elems = [elems;find(this.msh.([type 'Tags']) == from(k))];
    end
    elems = unique(elems);
    elemsTrue = intersect(elemsTrue,elems);
    numOfChanges = length(elemsTrue);
else
    elemsTrue = values;
    numOfChanges = sum(elemsTrue);
end

this.msh.(elemType).tags(elemsTrue) = to;
disp(['Modified ' num2str(numOfChanges) ' tags to ' num2str(to) '.'])