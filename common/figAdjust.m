function figAdjust(varargin)
  % Adjust some figure properties easily.
  %
  % No default values for varargin give, if you want to use them given them.
  % Property->value pairs are mainly function handles and their single
  % arguments. If you want something special, you shouldn't use this
  % function.
  %
  % varargin:
  %   - axis
  %   - box
  %   - caxis
  %   - grid
  %   - lim: set xlim and ylim to same value
  %   - title
  %   - xlabel
  %   - xlim
  %   - ylabel
  %   - ylim
  %   - zlabel
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  % properties that can be set
  params = {'lim','xlim','ylim','axis','view','caxis',...
    'grid','box',...
    'xlabel','ylabel','zlabel','title'};
  funs = {{@xlim,@ylim},@xlim,@ylim,@axis,@view,@caxis,...
    @grid,@box,...
    @xlabel,@ylabel,@zlabel,@title};
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
