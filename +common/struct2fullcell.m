function c = struct2fullcell(st,theseFieldsOnly)
  % Returns cell array of property value pairs from struct.
  %
  % parameters:
  %   - st: struct to be converted
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  allFields = fields(st);
  fieldsToConsider = {};
  if nargin > 1
    for k=1:length(theseFieldsOnly)
      if sum(strcmp(theseFieldsOnly{k},allFields)) == 1
        fieldsToConsider{end+1} = theseFieldsOnly{k};
      end
    end
  else
    fieldsToConsider = allFields;
  end   
  
  c = cell(1,2*length(fieldsToConsider));
  for k=1:length(fieldsToConsider)
    c{2*k-1} = fieldsToConsider{k};
    c{2*k} = st.(fieldsToConsider{k});
  end
  
end  
  