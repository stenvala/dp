function setInitElementEntities(this,nmbElems)
% Initialize msh structure for all the possible element types.
%
% parameters:
%   - nmbElems {0}: for how many element memory is allocated
%
% Created: Antti Stenvall (antti@stenvall.fi)
%

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
end
