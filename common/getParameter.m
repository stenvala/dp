%% getParameter.m
%
% get parameter from a list
% this is of matlab style {propertyName,propertyValue} given in varargin
% list to original function
%
% Created: Antti Stenvall (antti@stenvall.fi)

function val = getParameter(par,arr,default)
ind = find(strcmp(arr,par),1);
if isempty(ind) || length(arr) == ind
    if arguments.length < 3
        error('Paremeter ''par'' does not exist.');
    else
        val = default;
        return;
    end
end
val = arr{ind+1};

end