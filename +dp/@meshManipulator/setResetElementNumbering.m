function setResetElementNumbering(this)
  % Reset element numbering (might be useful if some elements were removed)
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  prevElem = 0;
  for k=1:length(this.reader)
    if isfield(this.msh,this.reader{k}.name)
      elemType = this.reader{k}.name;
      el = size(this.msh.(elemType).elems,1);
      this.msh.(elemType).nums = ((1:el)+prevElem)';
      prevElem = prevElem + el;
    end
  end
end
