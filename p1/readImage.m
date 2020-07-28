% Path of the filefold
SamplePath = '.\RedChair\RedChair\';
SavePath = '.\GrayChair\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(SamplePath,fileExt)); 
len = size(files,1);
% Get the whole files
for i=1:len
   fileName = strcat(SamplePath,files(i).name); 
   image = imread(fileName);
   % Convert RGB to grayscale
   I = rgb2gray(image);
   saveName = strcat(SavePath,files(i).name);
   % Save gray image
   imwrite(I,saveName); 
end


