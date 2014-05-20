function setDimensionToView(this)
  % In 2-D plotting, when the highest dimension is 2 view is set to [0 90]
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %  
  if this.dim == 2
    view([0 90]);
  else 
    view([-18 54]);
  end
  
end
