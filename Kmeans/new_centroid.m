function [im,temp]=new_centroid(x,k,rgb_val)
clust_mean=[];
%rgb_val=uint8(rgb_val);
for j=1:k

    numerator_r=sum(rgb_val(j,1:3:(x*3)));
    numerator_g=sum(rgb_val(j,2:3:(x*3)));
    numerator_b=sum(rgb_val(j,3:3:(x*3)));

    denominator=length(find(rgb_val(j,1:3:x*3)));
        
    new_centroid1(j,1)=numerator_r/denominator;    
    new_centroid1(j,2)=numerator_g/denominator;
    new_centroid1(j,3)=numerator_b/denominator;
   % end
    im(j,:)=new_centroid1(j,:);
    
end
temp=zeros(k,3);
temp=fix(new_centroid1 .*1e4)./1e4;
%rgb_val=im2double(rgb_val);
end

