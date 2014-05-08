%% getCoordinates.m
%
% get coordinates of the active chart
%
% Created: Antti Stenvall (antti@stenvall.fi)

function m = getCoordinates(this)

m = this.getActiveChart().coords;

end