function def = getDefaultColors(num)
% Returns default colors.
%
% parameters:
%   - num {some}: who many
%
% Created: Antti Stenvall (antti@stenvall.fi)

def = 'blue';

if nargin > 0 && num == 1    
    return
end
def = {def,'r',[0 0.5 0],'k','m',[0.5 0.5 0.5],'y'};

if nargin > 0 && num > length(def)
    def = getColorCell(num,def);
end