%% figAdjust.m
%
% adjust some figure properties based on data given at varargin
%
% Created: Antti Stenvall (antti@stenvall.fi)

function figAdjust(varargin)

% properties that can be set
params = {'lim','xlim','ylim','axis','view','caxis','xlabel','ylabel'};
funs = {{@xlim,@ylim},@xlim,@ylim,@axis,@view,@caxis,@xlabel,@ylabel};
for k=1:length(params)
    ind = find(strcmp(varargin,params{k}));
    if ~isempty(ind)
        value = varargin{ind+1};
        if ~iscell(funs{k})
            feval(funs{k},value);
        else
            for p=1:length(funs{k})
                feval(funs{k}{p},value);
            end
        end
    end
end

end