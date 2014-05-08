%% setDefaultParameters.m
%
% add default values to a cell array if those don't exist yet.
% this is of matlab style {propertyName,propertyValue} given in varargin
% and output is struct
%
% Created: Antti Stenvall (antti@stenvall.fi)

function def = setDefaultParameters(def,arr)
f = fields(def);
for k=1:length(f)
    ind = find(strcmp(arr,f{k}),1);
    if ~isempty(ind) && length(arr) ~= ind
        def.(f{k}) = arr{ind+1};
    end
end

end