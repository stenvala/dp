function setRemoveNaNelems(this)
  % Remove NaN elements from the end of element topological structure.
  %
  % This is handy when preallocation of element space is done, or when
  % elements are removed, tags can just be set to NaN.
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  for k=1:length(this.reader)
    type = this.reader{k}.name;
    if isfield(this.msh,type)
      keep = ~isnan(this.msh.(type).tags);
      if ~any(keep)
        this.msh = rmfield(this.msh,type);
      else
        f = fields(this.msh.(type));
        for p=1:length(f)
          data = this.msh.(type).(f{p});
          this.msh.(type).(f{p}) = data(keep,:);
        end
      end
    end
  end
end