function val = getParameter(par,arr,default)
% Get parameter from a property value list.
%
% parameters:
%   - par: property to be searcher
%   - arr: property->value list (cell array)
%   - default: if not found, search for this
%
% Created: Antti Stenvall (antti@stenvall.fi)

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