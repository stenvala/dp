function write(this,varargin)
% Write mesh to .msh file.
%
% varargin:
%   - fileName {this.project}: .msh file for writing
%   - elemEntityOffset {1000}: give another tag for every element. Add this
%     to their physical tag
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

defaults.fileName = [this.project '.msh'];
defaults.elemEntityOffset = 1000; % in gmsh we give two tags to the elements: physical and elementary entity.
% in dp we only save the physical, ee tag is given by adding a number to
% physical tag number and this determines the offset for that
param = setDefaultParameters(defaults,varargin);

f = fopen(param.fileName,'w');
%% initials
fprintf(f,'$MeshFormat\n','%s');
fprintf(f,'2.2 0 8\n','%s');
fprintf(f,'$EndMeshFormat\n','%s');
%% write coordinates
fprintf(f,'$Nodes\n','%s');
coords = this.getCoordinates();
fprintf(f,[num2str(size(coords,1)) '\n'],'%s');
for k=1:size(coords,1)
    fprintf(f,'%i %e %e %e \n',k,...
        coords(k,1),coords(k,2),coords(k,3));
end
fprintf(f,'$EndNodes\n','%s');
%% elements
fprintf(f,'$Elements\n','%s');
el = this.getNumberOfElements();
fprintf(f,'%i\n',el);
for p=1:length(this.reader.supportedTypes.names)
    type = this.reader.supportedTypes.names{p};
    if isfield(this.msh,type)
        tags = this.msh.(type).tags;
        elem = this.msh.(type).elems;
        nums = this.msh.(type).nums;
        % number, type, number of tags = 2, tag1 (physical), tag2 (entity),
        % nodes, in gmsh, one really only needs physical tags
        lineInit = '%i %i %i %i %i';        
        for k=1:this.reader.supportedTypes.vertices(p)
            lineInit = [lineInit ' %i'];
        end                
        for k=1:size(tags,1)                      
            nodes = num2cell(elem(k,:));            
            fprintf(f,[lineInit '\n'],...
                nums(k),...
                this.reader.supportedTypes.gmsh.types(p),...
                2,tags(k),tags(k)+param.elemEntityOffset,...
                nodes{:});
        end
    end    
end
fprintf(f,'$EndElements\n','%s');
fclose(f);
end