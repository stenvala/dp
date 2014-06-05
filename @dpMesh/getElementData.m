function st = getElementData(this,elemType)
  % Get element data from this.reader
  %
  % parameters:
  %   - elemType: type of element to be searched
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  st = nan;
  
  for k=1:length(this.reader)
    if strcmp(this.reader{k}.name,elemType)
      st = this.reader{k};
      return;
    end
  end
end
