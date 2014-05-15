%% showTagColors.m
%
% based on tag colors in param {colors, tags} display these pairs
%
% Created: Antti Stenvall (antti@stenvall.fi)

function showTagColors(title,param)

str = '---------------------';

disp(str)
disp(title)
disp(str)
for k=1:min([length(param.tags) length(param.colors)])
   c = param.colors{k};
   if isnumeric(c)
      c = num2str(c); 
   end   
   % cprintf and rgb from Matlab File Exchange
   cprintf(rgb(param.colors{k}),[num2str(param.tags(k)) ': ' c '\n']);
end
disp(str)