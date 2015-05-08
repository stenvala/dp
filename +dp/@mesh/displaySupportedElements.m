function displaySupportedElements(this,varargin)
  % Display data related to elements that are supported.
  %
  % varargin:
  %   - dim {0:3}: for which dimension(s) to display
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.dim = 0:3;
  param = common.setDefaultParameters(defaults,varargin);
  
  str = '---------------------';
  
  disp(str);
  fileExchange.cprintf.cprintf('*black','dpMesh supports following element types\n');
  disp(str);
  
  for k=param.dim
    fileExchange.cprintf.cprintf('blue','Elements with dimension ');
    fileExchange.cprintf.cprintf('*Blue',[num2str(k) '\n']);
    ind = find(cellfun(@(x) x.dim == k, this.reader));
    for p=ind
      fileExchange.cprintf.cprintf('red',['  ' this.reader{p}.description '\n']);
      fileExchange.cprintf.cprintf('black','    name: ');
      fileExchange.cprintf.cprintf('*magenta',[this.reader{p}.name '\n']);
      fileExchange.cprintf.cprintf('black','    number of vertices: ');
      fileExchange.cprintf.cprintf('*magenta',[num2str(this.reader{p}.vertices) '\n']);
    end
    disp(str);
  end    
end