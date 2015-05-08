function data = readFile(file)
  % Read lines of file to cell array.
  %
  % parameters:
  %   - file: path to file to be read
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  fid = fopen(file,'r');
  tline = fgetl(fid);
  data = {};
  while ischar(tline)
    data{end+1} = tline;
    tline = fgetl(fid);
  end
  fclose(fid);
end
