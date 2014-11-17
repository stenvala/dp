function setRemoveDuplicateCoordinates(this,tol)
  % Remove duplicate coordinates and fix element entities correspondingly
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  c = this.getCoordinates();
  if nargin > 1
    cu = round(c/tol);
  else
    cu = c;
  end
  
  [c,  ~, indNew] = unique(cu, 'rows');  
    
  %this.setUpdateCoordinates(c(indNew,:));
  
  this.setUpdateCoordinates(c);
  % update element entities  
  for p=1:length(this.reader)
    type = this.reader{p}.name;
    if isfield(this.msh,type)      
      this.msh.(type).elems = indNew(this.msh.(type).elems);     
    end
  end
end
