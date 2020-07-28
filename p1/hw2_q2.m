E=zeros(256,256);
V=zeros(256,256);
%read the image and apply the filter
%caculate the everage value
for i=1:10
   s=strcat('hw1/img',num2str(i),'.jpg');
   A=imread(s);
   B=double(imread(s));
   for j=2:255
      for k=2:255
         B(j,k)=A(j-1,k-1)/9+A(j-1,k)/9+A(j,k-1)/9+A(j,k)/9+A(j+1,k-1)/9+A(j+1,k)/9+A(j,k+1)/9+A(j+1,k+1)/9+A(j-1,k+1)/9;
      end
   end
B=B/10;
E=E+B;
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