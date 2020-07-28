% Path of the filefold
ReadinPath='.\DanaOffice\';
SavePath = '.\ResultOffice\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(ReadinPath,fileExt)); 
len = size(files,1);
fileName1 = strcat(ReadinPath,files(3).name);
fileName2 = strcat(ReadinPath,files(4).name);
saveName=strcat(SavePath,files(1).name);
saveName1=strcat(SavePath,files(2).name);
image2 = imread(fileName2);
image1 = imread(fileName1);
load('ncc_result');
[true_set,max_match,~]=Ransac(m,n,coor1,coor2);
t_size=size(true_set);
hom=least_square_homography(coor1,coor2,true_set,m,n);
[x,y,~]=size(image1);

result=[];

for a=1:x
     for b=1:y
        %temp=uint64(hom*[a;b;1]);
        temp=uint64([a,b,1]*hom);
        result(temp(1)+1,temp(2)+1,1:3)=image2(a,b,1:3);
        %result2(temp(1)+1,temp(1)+1,1:3)=image1(a,b,1:3);    
     end
end
 [~,sz]=size(true_set);
 x_offset=0;
 y_offset=5;
 for c=1:true_set
    if coor2(2,m(c))>x_offset 
        x_offset=int64(coor2(2,m(c)));
    end
 end
 x_offset=x_offset;
  [m2,n2,~]=size(image1);
  [m3,n3,~]=size(result);
  x_max=x_offset+n2;
  y_max=y_offset+m2;
  result1=zeros(y_max,x_max);
  result1(1:m3,1:x_offset,1:3)=result(1:m3,1:x_offset,1:3);
  result1(1:m2,x_offset+1:x_max,1:3)=image1(1:m2,1:n2,1:3);
  

imwrite((uint8(result)),saveName);
imwrite(uint8(result1),saveName1);