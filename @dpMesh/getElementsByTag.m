function [m v] = getElementsByTag(this,elemType,tag)
% Get elements (and their numbers) based on tags 
%
% parameters:
%   - elemType: short name for element
%   - tag: tag
% 
% Created: Antti Stenvall (antti@stenvall.fi)

t = this.getElementTopology(elemType);
tags = this.getElementTags(elemType);
m = t(tags == tag,:);
v = find(tag == tags);

end
