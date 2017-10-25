clc;
clear all;
Im=imread('G:\stevens\558\homeworks\hw3\wt_slic.png');

ir=im2double(Im);

ir=imresize(ir,0.5);
[xi,yi,z]=size(ir);%imshow(ir)
%new_temp=ir;

%i_temp=zeros(xi,yi);
 red=ir(:,:,1); green=ir(:,:,2); blue=ir(:,:,3);
array=[red(:),green(:),blue(:)]; 
[x,y]=size(array);
% 
 k=150;it=0; %k=2 it=11 k=10 it=33   
idx=randperm(x,k); %to initialize 10 random cluster centroid
im=array(idx,:);
    old_center=im;

    while true
        it=it+1;
clusters=zeros(k,x);
    rgb_val=zeros(k,x*3);
    fprintf('rgb%i\n' ,im);
  
[clusters,rgb_val]=make_cluster(array,x,k,clusters,im,rgb_val);
% figure
% imagesc(clusters)
[im,temp]=new_centroid(x,k,rgb_val);
temp_old=fix(old_center.*1e4)./1e4;
if temp_old==temp
    break;
else    
    
    old_center=im;
end
end
%rgb_new=zeros(xi ,yi);

for i=1:k
   % im(i)=mean(im(i,:));
    for j=1:x
      if clusters(i,j)~=0
          m=[xi yi];
          [l,o]=ind2sub(m,clusters(i,j));
          for f=1:3 
      

           ir(l,o,f)=im(i,f);
     
     end
     
      end
      end
end
figure,imagesc(ir);
