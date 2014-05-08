%% setInitMesh.m
%
% initialize mesh structure for all the possible element types
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setInitMesh(this,nmbElems)

for k=1:length(this.reader.supportedTypes.names)
    if nargin > 1
        if length(nmbElems) > 1
            e = nmbElems(k);
        else
            e = nmbElems;
        end
    else
        e = 0;
    end
    this.msh.(this.reader.supportedTypes.names{k}).elems = zeros(e,this.reader.supportedTypes.vertices(k))*nan;
    this.msh.(this.reader.supportedTypes.names{k}).nums = zeros(e,1)*nan;
    this.msh.(this.reader.supportedTypes.names{k}).tags = zeros(e,1)*nan;
end