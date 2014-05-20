function c = struct2fullcell(st)
  % Returns cell array of property value pairs from struct.
  %
  % parameters:
  %   - st: struct to be converted
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  f = fields(st);
  c = cell(1,2*length(f));
  for k=1:length(f)
    c{2*k-1} = f{k};
    c{2*k} = st.(f{k});
  end
  
end  
  