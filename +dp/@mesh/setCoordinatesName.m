function s = setCoordinatesName(this,name)
  % set name for current chart
  %
  % parameters:
  %   - name: name to be set
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  
  
  if this.chartsActive == 0
    error('Active chart not defined. Cannot set name. Do you have charts?');
  end
  for k=1:length(this.charts)
    if k ~= this.chartsActive && isfield(this.charts{k},'name') && ...
        strcmp(this.charts{k}.name,name)
      warning('This coordinate system name appears to be duplicate.');
    end
  end
  this.charts{this.chartsActive}.name = name;
  s = this.chartsActive;
end
