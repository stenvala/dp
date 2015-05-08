function writeParamFile(fileName,param)
  % Writes parameters file
  %
  % parameters:
  %   - fileName: file name where to write
  %   - param: struct of parameters to be written
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  fileID = fopen(fileName,'w');
  
  f = fields(param);
  
  for k=1:length(f)
    fprintf(fileID,'%s = %f;\n',f{k},param.(f{k}));
  end
  
  fclose(fileID);