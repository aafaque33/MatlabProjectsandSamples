function normalizerowandcolwise()

clc; % Clear command window.
clear all; % Delete all variables.
close all; % Close all figure windows except those created by imtool.
imtool close all; % Close all figure windows created by imtool.
workspace; % Make sure the workspace panel is showing.

outputfilerow = 'Normalizedrowwise.csv';
outputfilecol = 'Normalizedcolwise.csv';
inputfile = 'symmertry_norm.csv' ;

%% read Csv file 
fid = fopen(inputfile, 'rt');
raw = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s', 'Delimiter',','); %or whatever formatting your file is
fclose(fid);
%rownames = raw(:, 1);

%% Assign Cell data other than last column which stores in Cellnames

celldata = cell2mat(raw(:, 1:end-1));
cellname = raw(:, end);
cellnames = cellname{1,1};

[rows,cols] = size(celldata)

%% Normalize row wise

for i = 1:rows 
    rowdata = celldata(i,:);
    minval = min(rowdata);
    maxval = max(rowdata);
    
    row_norm = 2*((rowdata - minval)) / (maxval - minval) -1;
    row_normtocell = num2cell(row_norm);
    finalmatrixrow(i,:) = [row_normtocell cellnames(i)];
    
end

% Store in Normalizedrowwise.txt
dlmcell(strcat(pwd,filesep,outputfilerow),finalmatrixrow,',');

%% Normalize Column Wise

for i = 1:cols
    coldata = celldata(:,i);
    minval = min(coldata);
    maxval = max(coldata);
    
    col_norm(:,i) = 2*((coldata - minval)) / (maxval - minval) -1;
    
end

for i = 1: rows
    col_normtocell = num2cell(col_norm(i,:));
    finalmatrixcol(i,:) = [col_normtocell cellnames(i)];
end

% Store in Normalizedcolwise.txt
dlmcell(strcat(pwd,filesep,outputfilecol),finalmatrixcol,',');

end