function setCoordinatesTranslate(this,fun)
  % Translate current coordinates according to a function
  %
  % parameters:
  %   - fun: function handle that takes in n*3 matrix
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  this.charts{this.chartsActive}.coords = feval(fun,this.getCoordinates());
  
end
