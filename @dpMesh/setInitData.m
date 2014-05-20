function setInitData(this,varargin)
  % Set data to initdata structure.
  %
  % varargin:
  %   - see initdata in constructor
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  this.initdata = setDefaultParameters(this.initdata,varargin);
  
end
