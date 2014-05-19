function setTagsChangeByCoordFun(this,to,fun,elemEntity,from)
% Tag changer: change element tag when the center coordinate fulfils condition
%
% parameters:
%   - to 
%   - fun (takes in matrix n*3 of element center coordinates)
%   - elemEntity
%   - from {all elements}: you can only set to change from some
%
% Created: Antti Stenvall (antti@stenvall.fi)

if iscell(elemEntity)
   for k=1:length(elemEntity)
       if nargin > 4
            this.setTagsChange(to,fun,elemEntity{k},from);
       else
           this.setTagsChange(to,fun,elemEntity{k});
       end
   end
    return;
end

values = feval(fun,getCoordinatesAtElementCenter(this,elemEntity));

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

this.msh.(elemEntity).tags(elemsTrue) = to;
disp(['Modified ' num2str(numOfChanges) ' tags to ' num2str(to) '.'])