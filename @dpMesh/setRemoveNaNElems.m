%% setRemoveNaNElems.m
%
% Remove NaN elements. This is handy when preallocation of element space is
% done.
%
% Created: Antti Stenvall (antti@stenvall.fi)

function setRemoveNaNElems(this)

for k=1:length(this.reader.supportedTypes.names)
    
    until = find(isnan(this.msh.(this.reader.supportedTypes.names{k}).tags));
    if ~isempty(until)
        until = until - 1;
        if until == 0
            this.msh.(this.reader.supportedTypes.names{k}).elems = [];
            this.msh.(this.reader.supportedTypes.names{k}).nums = [];
            this.msh.(this.reader.supportedTypes.names{k}).tags = [];
        else
            this.msh.(this.reader.supportedTypes.names{k}).elems = this.msh.(this.reader.supportedTypes.names{k}).elems(1:until,:);
            this.msh.(this.reader.supportedTypes.names{k}).nums = this.msh.(this.reader.supportedTypes.names{k}).nums(1:until,:);
            this.msh.(this.reader.supportedTypes.names{k}).tags = this.msh.(this.reader.supportedTypes.names{k}).tags(1:until,:);
        end
    end
end