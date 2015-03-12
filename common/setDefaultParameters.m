function def = setDefaultParameters(def,arr,subvalue)
  % Set default parameters from a property->value list to struct, include
  % also those parameters that are not given in def.
  %
  % parameters:
  %   - def: default values
  %   - arr: property->value list struct
  %   - subvalue: is sub property->value list is searched from struct
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  f = fields(def);
  if nargin > 2 && ~isempty(subvalue)
    subInd = find(strcmp(arr,subvalue),1);
    if isempty(subInd) || length(arr) == subInd
      return;
    else
      arr = arr{subInd+1};
    end
  end
  
  for k=1:length(f)
    ind = find(strcmp(arr,f{k}),1);
    if ~isempty(ind) && length(arr) ~= ind
      def.(f{k}) = arr{ind+1};
    end
  end
  
  for k=1:2:length(arr)
    if ~any(strcmp(f,arr{k}))
      if length(arr) > k
        def.(arr{k}) = arr{k+1};
      end
    end
  end    
end
