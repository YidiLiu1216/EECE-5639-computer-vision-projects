function H=least_square_homography(coor1,coor2,true_set,m,n)
 [~,sz]=size(true_set);  
 A=zeros(sz.*2,6);
 B=zeros(sz,1);
 for i =1:sz
   A(i,1)=coor1(2,m(true_set(1,i)));
   A(i,2)=coor1(1,m(true_set(1,i)));
   A(i,5)=1;
   B(i,1)=coor2(2,n(true_set(1,i)));
 end
 for i=sz+1:sz*2
   A(i,3)=coor1(2,m(true_set(1,i-sz)));
   A(i,4)=coor1(1,m(true_set(1,i-sz)));
   A(i,6)=1;
   B(i,1)=coor2(1,n(true_set(1,i-sz)));
 end
 
 h=pinv(A)*B;
 h2=[h(1),h(2),h(5);h(3),h(4),h(6)];
 h2(3,1:3)=[0;0;1];
 h3=inv(h2);
 H=h3;

 
 h=pinv(A)*B;
 h2=[h(1),h(2),h(5);h(3),h(4),h(6)];
 h2(3,1:3)=[0;0;1];
 h3=inv(h2);
  H=h3;

end
