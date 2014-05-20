function addGeoFileContents(this,varargin)
  % Save .geo file contents.
  %
  % varargin:
  %   - fileName {[this.project].geo}
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.fileName = [this.project '.geo'];
  params = setDefaultParameters(defaults,varargin);
  this.geoFile.name = params.fileName;
  this.geoFile.contents = readFile(params.fileName);
end
