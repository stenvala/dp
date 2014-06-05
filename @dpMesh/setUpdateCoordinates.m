function setUpdateCoordinates(this,coordinates)
  % Replace coordinates with another one
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  this.charts{this.chartsActive}.coords = coordinates;
    
end