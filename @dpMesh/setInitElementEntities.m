function setInitElementEntities(this,nmbElems)
  % Initialize msh structure for all the possible element types.
  %
  % parameters:
  %   - nmbElems {0}: for how many element memory is allocated
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  for k=1:length(this.reader)
    if nargin > 1
      if length(nmbElems) > 1
        e = nmbElems(k);
      else
        e = nmbElems;
      end
    else
      e = 0;
    end
    this.msh.(this.reader{k}.name).elems = zeros(e,this.reader{k}.vertices)*nan;
    this.msh.(this.reader{k}.name).nums = zeros(e,1)*nan;
    this.msh.(this.reader{k}.name).tags = zeros(e,1)*nan;
    this.msh.(this.reader{k}.name).tagsElementary = zeros(e,1)*nan;
  end
end
