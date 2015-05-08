function write(this,varargin)
  % Write mesh to .msh file.
  %
  % varargin:
  %   - fileName {this.project}: .msh file for writing
  %   - elemTypeOffset {1000}: give another tag for every element. Add this
  %     to their physical tag
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  defaults.fileName = [this.project '.msh'];
  defaults.elemTypeOffset = 1000; % in gmsh we give two tags to the elements: physical and elementary entity.
  % in dp we only save the physical, ee tag is given by adding a number to
  % physical tag number and this determines the offset for that
  param = common.setDefaultParameters(defaults,varargin);
  f = fopen(param.fileName,'w');
  %% initials
  fprintf(f,'$MeshFormat\n','%s');
  fprintf(f,'2.2 0 8\n','%s');
  fprintf(f,'$EndMeshFormat\n','%s');
  %% write coordinates
  fprintf(f,'$Nodes\n','%s');
  coords = this.getCoordinates();
  fprintf(f,[num2str(size(coords,1)) '\n'],'%s');  
  fprintf(f,'%i %e %e %e \n',[cumsum(ones(size(coords,1),1)) coords]');  
  fprintf(f,'$EndNodes\n','%s');
  %% elements
  fprintf(f,'$Elements\n','%s');
  el = this.getNumberOfElements();
  fprintf(f,'%i\n',el);
  elNumber = 1;
  for p=1:length(this.reader)
    type = this.reader{p}.name;
    if isfield(this.msh,type)
      tags = this.msh.(type).tags;
      elem = this.msh.(type).elems;
      nums = this.msh.(type).nums;
      % number, type, number of tags = 2, tag1 (physical), tag2 (entity),
      % nodes, in gmsh, one really only needs physical tags
      lineInit = ['%i %i %i %i %i' repmat(' %i',1,this.reader{p}.vertices)];
      % next should be dome with repmat
      %for k=1:this.reader{p}.vertices
      %  lineInit = [lineInit ' %i'];
      %end      
      elNumbers = cumsum(ones(length(tags),1))-1+elNumber;
      % next element number
      elNumber = elNumbers(end) + 1;            
      fprintf(f,[lineInit ' \n'],[elNumbers ...        
        repmat(this.reader{p}.type.gmsh,length(elNumbers),1) ...
        2*ones(size(elNumbers)) ...
        tags tags+param.elemTypeOffset elem]');
    end
  end
  fprintf(f,'$EndElements\n','%s');
  fclose(f);
end