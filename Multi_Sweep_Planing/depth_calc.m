function output=depth_calc(plane1,plane2,plane3,imgdims)
output=zeros(imgdims(2),imgdims(1));
for i=1:img_dims(2)
    for j=1:img_dims(1)
        [~,idx]=max([plane1(i,j,2),plane2(i,j,2),plane3(i,j,2)]);
        if idx==1
            output(i,j)=plane1(i,j,1);
        elseif idx==2
            output(i,j)=plane2(i,j,1);
        else 
            output(i,j)=plane3(i,j,1);
        end
    end
end
end