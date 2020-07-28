% Path of the filefold
SamplePath = '.\DanaHallWay1\';
SavePath = '.\GrayHallWay\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(SamplePath,fileExt)); 
len = size(files,1);
% Get the whole files
for i=1:len
   fileName = strcat(SamplePath,files(i).name); 
   image = imread(fileName);
   % Calculate C matrix
   I = rgb2gray(image);
   saveName = strcat(SavePath,files(i).name);
   %Calculate harris
   %non_maximum suppression
   % Save corner image
   imwrite(I,saveName); 
end