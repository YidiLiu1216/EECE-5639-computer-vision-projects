% Path of the filefold
readin = '.\GrayChair\';
SavePath = '.\DiffChair\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(readin,fileExt)); 
len = size(files,1);
size_p=size(imread(strcat(readin,files(1).name)));
diff=zeros(size_p);
for i=1:1:len-1
    fileName = strcat(readin,files(i).name);
    fileName1= strcat(readin,files(i+1).name);
    frame = imread(fileName);
    frame1= imread(fileName1);
    framesub=double(abs(frame1-frame));
    saveName = strcat(SavePath,files(i).name);
    imwrite(uint8(framesub),saveName);
    diff=diff+framesub/(len-1);
 
end
a=max(max(diff));
%avg=0;
%for i = 1:size_p(1,1)
%     for j=1:size_p(1,2)
%        avg=avg+diff(i,j);
%     end
% end
% avg=avg/(size_P(1,1)*size_p(1,2));