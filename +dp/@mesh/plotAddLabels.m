function plotAddLabels(this,varargin)
  % Add labels to existing active figure
  % In properties all means show all, otherwise give indices in structure
  % not element numbers.
  %
  % varargin:
  %   - nodes: nodes to plot text on or all
  %   - any other element type like text and then vector of element indices
  %   or 'all'
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.nodes = nan;
  for k=1:length(this.reader)
    elemType = this.reader{k}.name;
    defaults.(elemType) = nan;
  end
  params = common.setDefaultParameters(defaults,varargin);
  c = this.getCoordinates();
  if ~all(isnan(params.nodes))
    if ~isnumeric(params.nodes)
      elem = 1:size(c,1);
    else
      elem = params.nodes;
    end
    for k=1:length(elem)
      text(c(elem(k),1),c(elem(k),2),c(elem(k),3), ...
        num2str(elem(k)),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','middle',...
        'BackgroundColor',[.7 .9 .7]);
    end
  end
  
  for k=1:length(this.reader)
    elemType = this.reader{k}.name;
    if ~all(isnan(params.(elemType)))
      elem = this.msh.(elemType).elems;
      if ~isnumeric(params.(elemType))
        ind = 1:size(elem,1);
      else
        ind = params.(elemType);
      end
      for p=1:length(ind)
        x = mean(c(elem(ind(p),:),1),1);
        y = mean(c(elem(ind(p),:),2),1);
        z = mean(c(elem(ind(p),:),3),1);
        c(elem(ind(p),:),1)
        text(x,y,z,...
          num2str(ind(p)),...
          'HorizontalAlignment','center',...
          'VerticalAlignment','middle',...
          'BackgroundColor',[.9 .7 .7]);
      end
    end
  end
  
end
