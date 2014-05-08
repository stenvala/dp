%% readFile.m
%
% read contents of a file to a cell array
%
% Created: Antti Stenvall (antti@stenvall.fi)

function data = readFile(file) % read lines of file to cell array
fid = fopen(file,'r');
tline = fgetl(fid);
data = {};
while ischar(tline)
    data{end+1} = tline;
    tline = fgetl(fid);
end
fclose(fid);
end