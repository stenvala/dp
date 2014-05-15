%% getColorCell.m
%
% returns n random colors possibly starting with default values
%
% Created: Antti Stenvall (antti@stenvall.fi)

function def = getColorCell(num,def)

if nargin < 2
    def = {};
end
while length(def) < num
    def{end+1} = rand(1,3);
end