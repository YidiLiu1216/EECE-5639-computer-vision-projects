% Path of the filefold
SamplePath = '.\GrayOffice\';
SavePath = '.\Officecorner\';
% File suffix
fileExt = '*.jpg';
% Get the path
files = dir(fullfile(SamplePath,fileExt)); 
len = size(files,1);
% Get the whole files
for i=1:len
   fileName = strcat(SamplePath,files(i).name);
   saveName=strcat(SavePath,files(i).name);
   image = imread(fileName);
   % Calculate C matrix
   image=double(image);
   [m,n]=size(image);
   tmp=zeros(m+2,n+2);  
   tmp(2:m+1,2:n+1)=image;
   Ix=zeros(m+2,n+2);
   Iy=zeros(m+2,n+2);
   %Calculate Ix,Iy
   Ix(:,2:n)=(tmp(:,3:n+1)-tmp(:,1:n-1))/2;
    Iy(2:m,:)=(tmp(3:m+1,:)-tmp(1:m-1,:))/2;
    Ix2=Ix(2:m+1,2:n+1).^2;
    Iy2=Iy(2:m+1,2:n+1).^2;
    Ixy=Ix(2:m+1,2:n+1).*Iy(2:m+1,2:n+1);
    %use 7*7 gaussian window
    h=fspecial('gaussian',[7 7],2);
    Ix2=filter2(h,Ix2);
    Iy2=filter2(h,Iy2);
    Ixy=filter2(h,Ixy);
   %Calculate harris
   k=0.05;
   Rmax=0;
    R=zeros(m,n);
    for a=1:m
        for b=1:n
            M=[Ix2(a,b) Ixy(a,b);Ixy(a,b) Iy2(a,b)];
            R(a,b)=det(M)-k*(trace(M))^2;     
            if R(a,b)>Rmax
                Rmax=R(a,b);
            end
        end
    end
   %non_maximum suppression in 3*3 matrix
   Corner=zeros(m,n);
   tmp(2:m+1,2:n+1)=R;
     for a=2:m+1
        for b=2:n+1
            if tmp(a,b)>0.005*Rmax &&...
               tmp(a,b)>tmp(a-1,b-1) && tmp(a,b)>tmp(a-1,b) && tmp(a,b)>tmp(a-1,b+1) &&...
               tmp(a,b)>tmp(a,b-1) && tmp(a,b)>tmp(a,b+1) &&...
               tmp(a,b)>tmp(a+1,b-1) && tmp(a,b)>tmp(a+1,b) && tmp(a,b)>tmp(a+1,b+1)
                    Corner(a-1,b-1)=255;
            else
                Corner(a-1,b-1)=0;
            end    
        end
     end
     imwrite(uint8(Corner),saveName); 
   % Save corner image
end
