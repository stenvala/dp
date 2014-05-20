function c = displaySupportedElements(this,varargin)
  % Display data related to elements that are supported.
  %
  % varargin:
  %   - dim {0:3}: for which dimension(s) to display
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.dim = 0:3;
  param = setDefaultParameters(defaults,varargin);
  
  str = '---------------------';
  
  disp(str);
  cprintf('*black','dpMesh supports following element types\n');
  disp(str);
  
  for k=param.dim
    cprintf('blue','Elements with dimension ');
    cprintf('*Blue',[num2str(k) '\n']);
    ind = find(cellfun(@(x) x.dim == k, this.reader));
    for p=ind
      cprintf('red',['  ' this.reader{p}.description '\n']);
      cprintf('black','    name: ');
      cprintf('*magenta',[this.reader{p}.name '\n']);
      cprintf('black','    number of vertices: ');
      cprintf('*magenta',[num2str(this.reader{p}.vertices) '\n']);
    end
    disp(str);
  end
  
  c = this.reader;
end