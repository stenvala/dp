function [strElem, strBnd] = getSimplexElementType(this)
  % Return simplex element type for the given mesh and its boundary
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  switch this.getDim()
    case 1 % one-dimensional problems
      strBnd = 'vtx';
      if isfield(this.getMesh(),'edg')
        strElem = 'edg';
      elseif isfield(this.getMesh(),'edg2')
        strElem = 'edg2';
      elseif isfield(this.getMesh(),'edg3')
        strElem = 'edg3';
      elseif isfield(this.getMesh(),'edg4')
        strElem = 'edg4';
      end
    case 2 % two-dimensional problems
      if isfield(this.getMesh(),'tri')
        strElem = 'tri';
        strBnd = 'edg';
      elseif isfield(this.getMesh(),'tri2')
        strElem = 'tri2';
        strBnd = 'edg2';
      elseif isfield(this.getMesh(),'tri3')
        strElem = 'tri3';
        strBnd = 'edg3';
      elseif isfield(this.getMesh(),'tri4')
        strElem = 'tri4';
        strBnd = 'edg4';
      end
    case 3 % three-dimensional problems
  end
  
  
end