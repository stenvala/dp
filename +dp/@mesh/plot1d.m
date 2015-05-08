function h = plot1d(this,varargin)
  % Plot 1d elements.
  %
  % varargin:
  %   - colors {default1}: color for edges  
  %   - faceColor {none}: color for faces
  %   - view {[0 90]}: view, default value only in 2-D   
  %
  %   - see for more: help fig, help common.figAdjust
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  if this.dim == 2
    defaults.view = [0 90];
  end  
  defaults.colors = common.getDefaultColors(1);
  defaults.faceColor = 'none';  
  param = common.setDefaultParameters(defaults,varargin);
  param.showTagColors = 0;
  c = common.struct2fullcell(param);
  h = this.plotPhysicalDomains1d(c{:});    
end

