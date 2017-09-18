function [dir,mag]= Filtering(I,sigma)
D=double(I); %to convert it into double precision value.
size1=round(3*sigma); %window size
[x,y]=meshgrid(-size1:size1,-size1:size1); %since x and y needs to be identical
M=size(x,1)-1; %size() returns no.of rows
D=padarray(D,[size1 size1],'replicate');

%for sigma=1:10 %starting gaussian kernel, sigma is standard deviation
e=exp(-(x.^2+y.^2)/(2*sigma*sigma));
kernel=e/(2*pi*sigma*sigma);
kernel=kernel./sum(kernel(:));
        %subplot(2,2,3);
%convolution
for i=1:size(D,1)-M
    for j=1:size(D,2)-M %size of no of columns of D
        temp=D(i:i+M,j:j+M).*kernel;
        output(i,j)=sum(temp(:));
    end
end
output12=uint8(output);
%figure, imagesc(output12);
%title('Gaussian filtered');
output1=double(output12);
%Sobel Filter
for i=1:size(output1,1)-2
    for j=1:size(output1,2)-2
        %for x direction
        Gdx=(output1(i+2,j)+(2*output1(i+2,j+1))+output1(i+2,j+2))-(output1(i,j)+(2*output1(i,j+1))+output1(i,j+2));
        %dx(i,j)=diff(Gdx);
        %for y direction2
        Gdy=(output1(i,j+2)+(2*output1(i+1,j+2))+output1(i+2,j+2))-(output1(i,j)+(2*output1(i+1,j))+output1(i+2,j));
        %dy=diff(Gdy);
        mag(i,j)=sqrt(Gdx.^2+Gdy.^2);
        dir(i,j)=abs(atand(Gdy/Gdx)); %in degree
    end
end
mag=uint8(mag);
Threshold=28;
%defining threshold value
mag=max(mag,Threshold); % if anywhere threshold is greater than mag value then it will be replaced by Threshold
mag(mag==Threshold)=0; %wherever it will find threshold it will assign 0 to that place
end
