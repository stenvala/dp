%% getActiveChart.m
%
% get string name for simplex of defined dimension
%
% Created: Antti Stenvall (antti@stenvall.fi)

function s = getActiveChart(this)
s = this.charts{this.chartsActive};
