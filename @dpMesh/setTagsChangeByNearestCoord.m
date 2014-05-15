%% setTagsChangeByNearestCoord
%
% determine tag by searching the nearest coordinate and then change these
% tags
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setTagsChangeByNearestCoord(this,to,coord,elemEntity)

if iscell(elemEntity)
   for k=1:length(elemEntity)
       this.setTagsChangeByNearestCoord(to,coord,elemEntity{k});
   end
    return;
end

c = this.getCoordinatesAtElementCenter(elemEntity);

dist = (c(:,1)-coord(1)).^2+(c(:,2)-coord(2)).^2+(c(:,3)-coord(3)).^2;

minInd = find(dist == min(dist),1);

from = this.msh.(elemEntity).tags(minInd);

this.setTagsChange(from,to,elemEntity);