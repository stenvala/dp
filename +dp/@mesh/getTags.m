function tags = getTags(this,elemType)
  % Tag getter: get all tags of specific element type
  %
  % parameters:  
  %   - elemType
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  
  tags = [];
  
  if iscell(elemType)
    for k=1:length(elemType)
      tags = [tags this.getTags(elemType{k})];
    end
    tags = unique(tags);
    return;
  end
  
  try    
      tags = unique(this.msh.(elemType).tags);    
  catch e
    exception = MException('SetError:RequestedElementTypeDoesNotExist', ...
      ['Tried to modify tag of an unexisting element type: ' elemType]);
    throw(exception);
  end
end
