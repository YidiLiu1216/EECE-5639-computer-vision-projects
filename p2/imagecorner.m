%show image with corner point
% Path of the filefold
SamplePath = '.\HallWaycorner\';
ReadinPath='.\GrayHallWay\';
SavePath = '.\HallWaywithcorner\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(SamplePath,fileExt)); 
len = size(files,1);
% Get the whole files
for i=1:len
   fileName = strcat(SamplePath,files(i).name);
   saveName=strcat(SavePath,files(i).name);
   readinName=strcat(ReadinPath,files(i).name);
   image = imread(fileName);
   image1= imread(readinName);
   [m,n]=size(image);
   res=zeros(m,n);
   temp=ones(m,n);
   for a=1:m
      for b=1:n
          res=((double(temp)-double(image./255))).*double(image1);
      end
   end
   imwrite(uint8(res),saveName);
end