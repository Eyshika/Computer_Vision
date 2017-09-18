function newdir=NMS(mag,dir)

[n,m]=size(mag);
newdir=0;
for i=2:n-1
   for j=2:m-1
       if((dir(i,j)>=0) && (dir(i,j)<=22.5)) %for horizontal
           ndir(i,j)=0;
       
       elseif((dir(i,j)>=22.6) && (dir(i,j)<=45.1)) %for diagonal1
           ndir(i,j)=45;
       elseif((dir(i,j)>=45.2) && (dir(i,j)<=67.7)) %for vertical
           ndir(i,j)=90;
       else    %for diagonal2
           ndir(i,j)=135;
       end
           %NMS
       if(ndir(i,j)==0)
           if((mag(i,j)<mag(i-1,j))||(mag(i,j)<mag(i+1,j)))
               newdir(i,j)=0;
           else
               newdir(i,j)=mag(i,j);
           end
       end
       if(ndir(i,j)==45)
           if((mag(i,j)<mag(i+1,j-1))||(mag(i,j)<mag(i-1,j+1)))
               newdir(i,j)=0;
           else
               newdir(i,j)=mag(i,j);
           end
       end
       if(ndir(i,j)==90)
           if((mag(i,j)<mag(i,j-1))||(mag(i,j)<mag(i,j+1)))
               newdir(i,j)=0;
           else
               newdir(i,j)=mag(i,j);
           end
       end
       if(ndir(i,j)==135)
           if((mag(i,j)<mag(i-1,j-1))|| (mag(i,j)<mag(i+1,j+1)))
               newdir(i,j)=0;
           else
               newdir(i,j)=mag(i,j);
           end
       end
       
   end
end
end 

