function setRemoveNaNElems(this)
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
      until = find(isnan(this.msh.(type).tags));
      if ~isempty(until)
        f = fields(this.msh.(type));
        until = until - 1;
        for p=1:length(f)
          if until == 0
            this.msh.(type).(f{p}) = [];
          else
            this.msh.(type).(f{p}) = this.msh.(type).(f{p})(1:until,:);
          end
        end
      end
    end
  end
end