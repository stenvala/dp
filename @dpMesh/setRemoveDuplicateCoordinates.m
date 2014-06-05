function setRemoveDuplicateCoordinates(this)
  % Remove duplicate coordinates and fix element entities correspondingly
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  c = this.getCoordinates();
  
  [cNew,  ~, indNew] = unique(c, 'rows');
  this.setUpdateCoordinates(cNew);
  % update element entities  
  for p=1:length(this.reader)
    type = this.reader{p}.name;
    if isfield(this.msh,type)      
      this.msh.(type).elems = indNew(this.msh.(type).elems);     
    end
  end
end
