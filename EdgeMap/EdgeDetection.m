%% Programmer
% Aafaque Aafaque

%% Function Start

function EdgeDetection()

%% Clear workspace and Variables
clc; % Clear command window.
clear all; % Delete all variables.
close all; % Close all figure windows except those created by imtool.
imtool close all; % Close all figure windows created by imtool.
workspace; % Make sure the workspace panel is showing.

%% Read Images
%  Directory path and Extension of files to read
inputDir = 'Inputimages';
imgExt = '.jpg' ;

directory = [pwd filesep inputDir] ;
Images = dir([directory filesep '*' imgExt]); % get all images in Directory with  defined ext


for N = 1:length(Images) % Number of images in directory
    
    file = [directory filesep Images(N).name]; % Full file path
    [pathstr,name,ext] = fileparts(file); % Separate Path, filename and ext
    
    filename = name  ; % extract Filename for future use
    
    %% Read Images
    
    %Read the images one by one
    I = imread(file);
    
    %se = strel('line',11,90);
    %I = imdilate(I,se); or %I = imerode(I,se);
    
    %% Convert into Grayscale only if in RGB
    
    if size(I, 3) == 3
        Igray = rgb2gray(I);
    else
        Igray = I;
    end
    
    %% Edge Detection
    
    Icanny = edge(Igray,'Canny');
    Isobel = edge(Igray,'Sobel');
    Iprewitt = edge(Igray,'Prewitt');
    Iroberts = edge(Igray,'Roberts');
    Izerocross = edge(Igray,'zerocross');
    Ilog = edge(Igray,'log');
    
    
    %% Create output directory for each image
    
    if exist(strcat(pwd,filesep,filename), 'dir')
        rmdir(strcat(pwd,filesep,filename),'s');
        mkdir(strcat(pwd,filesep,filename));
    else
        mkdir(strcat(pwd,filesep,filename));
    end
    
    %% Ouptut Edge Images
    
    imwrite(Icanny, strcat(pwd,filesep,filename,filesep,filename,'_Canny',ext));
    imwrite(Isobel, strcat(pwd,filesep,filename,filesep,filename,'_Sobel',ext));
    imwrite(Iprewitt, strcat(pwd,filesep,filename,filesep,filename,'_Prewitt',ext));
    imwrite(Iroberts, strcat(pwd,filesep,filename,filesep,filename,'_Roberts',ext));
    imwrite(Izerocross, strcat(pwd,filesep,filename,filesep,filename,'_Zerocross',ext));
    imwrite(Ilog, strcat(pwd,filesep,filename,filesep,filename,'_LaplacianogfGuassian',ext));
    
    
end

end
