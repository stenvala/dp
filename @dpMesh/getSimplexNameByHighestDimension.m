%% getSimplexNameByHighestDimension.m
%
% get string name for simplex of defined dimension
%
% Created: Antti Stenvall (antti@stenvall.fi)

function s = getSimplexNameByHighestDimension(this)

switch this.dim
    case 2; s = 'tri';
    case 3; s = 'tet';
end
end