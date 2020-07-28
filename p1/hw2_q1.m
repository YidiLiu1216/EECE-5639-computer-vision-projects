
%generate the origin image
I=uint8(ones(256,256)*128);
%add noise and save the ten images
for i=1:10
   s=strcat('hw1/img',num2str(i),'.jpg');
   A=imnoise(I,'gaussian',0,4.0/255^2);
   imwrite(A,s);
end
%declar the everage and variance value
E=zeros(256,256);
V=zeros(256,256);
%read the image and apply the filter
%caculate the everage value
for i=1:10
   s=strcat('hw1/img',num2str(i),'.jpg');
   A=imread(s);
   A=double(A)/10;
   E=E+A;
end
%calculate the variance value
for i=1:10
   s=strcat('hw1/img',num2str(i),'.jpg');
   A=imread(s);
   A=double(A);
   V=V+(E-A).^2;
end
V=(V/9).^(1/2);
%calculate the average_est_noise
%calculate the max_est_noise
average_est_noise=0;
max_est_noise=0;
for i= 1:256
    for j= 1:256
       average_est_noise=V(i,j)+average_est_noise;
       if max_est_noise<V(i,j)
           max_est_noise=V(i,j);
       end
    end
end
average_est_noise=average_est_noise/256^2;
