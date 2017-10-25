function [clusters,rgb_val]=make_cluster(array,x,k,clusters,im,rgb_val)

for o=1:x 
%     for j=1:y-1
        copy=vec2mat(repmat(array(o,:),1,k),3); %make 1X10 array of each point
    dist=im-copy;
    dist_norm=sqrt((dist(:,1).^2+dist(:,2).^2+dist(:,3).^2)); %euclidean distance
     [m(o),ind(o)]=min(dist_norm); %gives min distance value of each pixel and the cluster
%    
      rgb_val(ind(o),3*o-2:3*o)=array(o,:); %storing values row is cluster no 
  
    
     clusters(ind(o),o)=o; %storing indexes
     
end 
 
         

end