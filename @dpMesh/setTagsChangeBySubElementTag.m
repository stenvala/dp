function setTagsChangeBySubElementTag(this,to,elemEntity,subEntity,subTag,from)
% Tag changer: if subelement (like tri of tet) has tag, change tag
%
% Allows the change tags having edge with specific tag etc. This can be
% beneficial in visualizing supports of cohomology basis functions which
% are related to edges with specific tags. Or when an n-boundary element 
% layer of (n-1)-boundary is searched.
%
% parameters:
%   - to
%   - elemEntity: n-dim entity
%   - subEntity: (n-1)-dim elements
%   - subTag: tag of (n-1) elements
%   - from {all}: search only for these elements
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

if nargin > 5 && ~isempty(from)
    [t ind] = this.getElementsByTag(elemEntity,from);
else
    t = this.getElementTopology(elemEntity);
    ind = (1:size(t,1))';
end

subElements = this.getElementsByTag(subEntity,subTag);
for k=1:size(subElements,1)
    elToChange = sum(ismember(t,subElements(k,:)),2) == size(subElements,2);
    this.msh.(elemEntity).tags(ind(elToChange)) = to;
end

end