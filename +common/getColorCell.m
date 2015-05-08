function def = getColorCell(num,def)
  % Returns n random colors possibly starting with default values
  %
  % parameters:
  %   - num: how many colors to return
  %   - def: give initial cell array, this is lengthened if needed then, if
  %   thi is string, returns cell array of these length num
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %  
  
  if nargin < 2
    def = {};
  elseif ~iscell(def)
    val = {};
    while length(val) < num
      val{end+1} = def;
    end  
    def = val;
    return
  end
  while length(def) < num
    def{end+1} = rand(1,3);
  end
end
