clc;
clear all;
I_left=imread('G:\stevens\532\assignment\2\teddyL.pgm');
I_right=imread('G:\stevens\532\assignment\2\teddyR.pgm');
Ground=imread('G:\stevens\532\assignment\2\disp2.pgm');
 ground_div=round(Ground/4);

%Ground=double(Ground);
%padded image for boundary points
D_left=padarray(I_left,[2 2],'replicate');
D_right=padarray(I_right, [2,2], 'replicate');
I_rank_left=zeros(size(I_left));
I_rank_right=zeros(size(I_right));

%Rank transformation
disp('..Calculating rank transform...\n');
for i=1:size(D_left,1)-4
    for j=1:size(D_left,2)-4
        win1(1:5,1:5)=double(D_left(i:i+4,j:j+4));
        win2(1:5,1:5)=double(D_right(i:i+4,j:j+4));
        I_rank_left(i,j)=sum(sum(win1<=win1(3,3))); %update center value of window
        I_rank_right(i,j)=sum(sum(win2<=win2(3,3)));
    end
end
%padded image for boundary as 0
I_rank_r_pad_3=padarray((I_rank_right), [1,1]);
I_rank_l_pad_3=padarray((I_rank_left), [1,1]);

%3X3 window Right refrenced
disp('..Calculating SAD for 3X3 window...\n');

%When right image is refrenced window is moved right side of left image
%So loop started from first pixel of row to last pixel and window is slided
%right sided covering 0-63 disparity. Also, right window is subtracted from
%left window for SAD.
I_sad_3=zeros(size(I_left));
PRKN=zeros(size(I_left,1)*size(I_left,2),3);
count=1;
for i=1:size(I_rank_l_pad_3,1)-2
    for k=1:size(I_rank_l_pad_3,2)-2 
     store3=[];
       m=1;
       l=min(k+63,size(I_left,2));
       for j=k:l
           window3_left(1:3,1:3)=I_rank_r_pad_3(i:i+2,k:k+2);
            window3_right(1:3,1:3)=I_rank_l_pad_3(i:i+2,j:j+2);
            store3(1,m)=sum(sum(abs(window3_right-window3_left)));
            
         m=m+1;
       end
       [~, column_3]=min(store3);
        xr_3=column_3-1;
        I_sad_3(i,k)=xr_3;
        value=sort(store3);
        %2nd minimum/minimum
        if numel(value)>1
         PRKN(count,:)=[value(2)/value(1),i,k];
           if value(1)==0
                PRKN(count,:)=[1,i,k];
           end
        else
            PRKN(count,:)=[1,i,k];
        end
        count=count+1;
    end
end
disp('..Calculating PRKN...');
highest_confidence=median(PRKN(:,1));
I_sad_3_p=zeros(size(I_sad_3));
diff=zeros(size(I_sad_3));

for i=1:size(I_left,1)*size(I_left,2)
    if PRKN(i,1)>highest_confidence
        I_sad_3_p(PRKN(i,2),PRKN(i,3))=I_sad_3(PRKN(i,2),PRKN(i,3));
        diff(PRKN(i,2),PRKN(i,3))=uint8(I_sad_3_p(PRKN(i,2),PRKN(i,3)))-ground_div(PRKN(i,2),PRKN(i,3));
    end
end
I_sad_3_p=I_sad_3_p*4;  %multiplied by 4 so that disparity map can be clear in view
figure,
imshow(uint8(I_sad_3_p));
title('Sparse Disparity map');

I_sad_3=I_sad_3*4;
figure,
imshow(uint8(I_sad_3));
title('3X3 window right refrenced');

%3X3 window left refrenced

%When left image is refrenced window is moved left side of right image
%So loop started from end pixel of row to 1st pixel and window is slided
%left sided.
I_sad_3l=zeros(size(I_left));
for i=(size(I_rank_l_pad_3,1)-2):-1:1
    for k=(size(I_rank_l_pad_3,2)-2):-1:1
     store3=[];
       m=1;
       l=max(k-63,1);
       for j=k:-1:l
           window3l_left(1:3,1:3)=I_rank_l_pad_3(i:i+2,k:k+2);
            window3l_right(1:3,1:3)=I_rank_r_pad_3(i:i+2,j:j+2);
            store3(1,m)=sum(sum(abs(window3l_left-window3l_right)));
            
         m=m+1;
       end
       [~, column_3]=min(store3);
        xr_3=column_3-1;
        I_sad_3l(i,k)=xr_3;
    end
end
I_sad_3l=I_sad_3l*4;
figure,
imshow(uint8(I_sad_3l));
title('3X3 window Left refrenced');

%15X15 window right refrenced
disp('..Calculating SAD for 15X15 window...\n');

I_rank_r_pad_5=padarray((I_rank_right), [7,7]);
I_rank_l_pad_5=padarray((I_rank_left), [7,7]);
I_sad_5=zeros(size(I_left));
for i=1:size(I_rank_l_pad_5,1)-14
    for k=1:size(I_rank_l_pad_5,2)-14 
     store5=[];
       m=1;
       l=min(k+63,size(I_right,2));
       for j=k:l
           window5_left(1:15,1:15)=I_rank_r_pad_5(i:i+14,k:k+14);
            window5_right(1:15,1:15)=I_rank_l_pad_5(i:i+14,j:j+14);
            store5(1,m)=sum(sum(abs(window5_right-window5_left)));
            
         m=m+1;
       end
       [~, column_5]=min(store5);
        xr_5=column_5-1;
        I_sad_5(i,k)=xr_5;
    end
end
I_sad_5=I_sad_5*4;
figure,
imshow(uint8(I_sad_5));
title('15 X 15 Right Refrenced');

%15X15 window left refrenced
I_sad_5l=zeros(size(I_left));
for i=(size(I_rank_l_pad_5,1)-14):-1:1
    for k=(size(I_rank_l_pad_5,2)-14):-1:1
     store5=[];
       m=1;
       l=max(k-63,1);
       for j=k:-1:l
           window5l_left(1:15,1:15)=I_rank_l_pad_5(i:i+14,k:k+14);
            window5l_right(1:15,1:15)=I_rank_r_pad_5(i:i+14,j:j+14);
            store5(1,m)=sum(sum(abs(window5l_left-window5l_right)));
            
         m=m+1;
       end
       [~, column_5]=min(store5);
        I_sad_5l(i,k)=column_5-1;
        
    end
end
I_sad_5l=I_sad_5l*4;
figure,
imshow(uint8(I_sad_5l));
title('15X15 window Left refrenced');

%Finding percentage Error
 diff_3=uint8(I_sad_3/4)-ground_div;
 diff_3l=uint8(I_sad_3l/4)-ground_div;
 diff_5=uint8(I_sad_5/4)-ground_div;
 diff_5l=uint8(I_sad_5l/4)-ground_div;

 number_3=numel(diff_3(diff_3>1));
 number_3l=numel(diff_3l(diff_3l>1));
 number_5=numel(diff_5(diff_5>1));
 number_5l=numel(diff_5l(diff_5l>1));
number_3p=numel(diff(diff>1));

percent_3=(number_3/(size(Ground,1)*size(Ground,2)))*100;
percent_3l=(number_3l/(size(Ground,1)*size(Ground,2)))*100;
percent_5=(number_5/(size(Ground,1)*size(Ground,2)))*100;
percent_5l=(number_5l/(size(Ground,1)*size(Ground,2)))*100;
percent_3p=(number_3p/numel(I_sad_3_p(I_sad_3_p>0)))*100;

 disp('....Calculation Error rate..');
fprintf('Error Rate of 3x3 window when Right image is refrenced:\n %f',percent_3);
fprintf('\nError Rate of 3x3 window when Left image is refrenced:\n %f',percent_3l);
fprintf('\nError Rate of 15X15 window when Right image is refrenced:\n %f',percent_5);
fprintf('\nError Rate of 15X15 window when Left image is refrenced:\n %f\n',percent_5l);
fprintf('\n Error rate of Number of pixels and Sparse matrix: %f', percent_3p);