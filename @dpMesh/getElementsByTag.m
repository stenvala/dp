function [m v] = getElementsByTag(this,elemEntity,tag)
% Get elements (and their numbers) based on tags 
%
% parameters:
%   - elementEntity: short name for element
%   - tag: tag
% 
% Created: Antti Stenvall (antti@stenvall.fi)

t = this.getElementTopology(elemEntity);
tags = this.getElementTags(elemEntity);
m = t(tags == tag,:);
v = find(tag == tags);

end
