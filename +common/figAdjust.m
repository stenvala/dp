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
  %   - zlim
  %   - axisEqualXY (set value, but it does not matter what it is)
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  % properties that can be set
  params = {'axis','lim','xlim','ylim','zlim','view','caxis',...
    'grid','box',...
    'axisEqualXY',...
    'xlabel','ylabel','zlabel','title'};
  funs = {@axis,{@xlim,@ylim},@xlim,@ylim,@zlim,@view,@caxis,...
    @grid,@box,...
    @(dummy) set(gca, 'DataAspectRatio', [repmat(min(diff(get(gca, 'XLim')), diff(get(gca, 'YLim'))), [1 2]) diff(get(gca, 'ZLim'))]), ...
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
