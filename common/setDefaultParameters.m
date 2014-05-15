%% setDefaultParameters.m
%
% add default values to a cell array if those don't exist yet.
% this is of matlab style {propertyName,propertyValue} given in varargin
% and output is struct, if subvalue is given then it is searched from array
%
% Created: Antti Stenvall (antti@stenvall.fi)

function def = setDefaultParameters(def,arr,subvalue)
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

end