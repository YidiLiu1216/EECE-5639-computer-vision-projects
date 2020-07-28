m=zeros(7,7);
for i= 1:7
    for j= 1:7
        m(i,j)=exp((-(i-4)^2-(j-4)^2)/(2*1.4*1.4));
    end
end

x=zeros(7,1);
y=zeros(1,7);
for i=1:7
   x(i,1)=exp((-(i-4)^2)/(2*1.4*1.4));
   y(1,i)=exp((-(i-4)^2)/(2*1.4*1.4));
end
m1=x*y;