% Path of the filefold
readin = '.\DiffChair\';
Origin='.\RedChair\RedChair\';
SavePath = '.\MaskChair\';
% File suffix
fileExt = '*.jpg';

files = dir(fullfile(readin,fileExt)); 
size_p=size(imread(strcat(readin,files(1).name)));
len = size(files,1);
threshold=5/255;
output=zeros(size_p(1),size_p(2),3);
for i=2:len
    fileName = strcat(readin,files(i).name);
    OriName = strcat(Origin,files(i).name);
 
    diff = imread(fileName);
    ori=imread(OriName);
   
    mask=imbinarize(diff,threshold);
   
    for m=1:size_p
       for n=1:size_p
           for k= 1:3
              output(m,n,k)=uint8(mask(m,n))*ori(m,n,k);
           end
       end
    end
    saveName = strcat(SavePath,files(i).name);
    imwrite(uint8(output),saveName);
end
