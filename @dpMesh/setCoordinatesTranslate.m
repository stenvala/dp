%% setCoordinatesTranslate.m
%
% Translate coordinates
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setCoordinatesTranslate(this,fun)

this.charts{this.chartsActive}.coords = feval(fun,this.getActiveChart().coords);

end