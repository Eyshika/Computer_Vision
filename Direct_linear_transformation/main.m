clear all;
% Read Image
I=imread('G:\stevens\532\assignment\1\basketball-court.ppm');
figure, imshow(I); %display original image
cols_new=500;
rows_new=940;
 I_output = 255 * ones( rows_new,cols_new, 'uint8'); %blank image
%normalization matrix for new and original image
T_norm=[size(I,1)+size(I,2) 0 size(I,2)/2;
    0 size(I,1)+size(I,2) size(I,1)/2;
    0 0 1];
T_norm_new=[cols_new+rows_new 0 cols_new/2;
    0 cols_new+rows_new rows_new/2;
    0 0 1];
%Original points of badminton court
x1_p=44;
y1_p= 244;
x2_p=71;
y2_p= 418;
x3_p=203;
y3_p= 1;
x4_p =319;
y4_p= 290;
x1=[x1_p;y1_p;1];
x2=[x2_p;y2_p; 1];
x3=[x3_p; y3_p; 1];
x4=[x4_p; y4_p; 1];
%Normalized Points
x1_t=T_norm*x1;
x2_t=T_norm*x2;
x3_t=T_norm*x3;
x4_t=T_norm*x4;

%new points of image
x1_new=1;
y1_new =1;
x2_new= 1;
y2_new=500;
x3_new=940;
y3_new=1;
x4_new=940;
y4_new=500;
x1_new_mat=[x1_new; y1_new;1];
x2_new_mat=[x2_new; y2_new;1];
x3_new_mat=[x3_new; y3_new;1];
x4_new_mat=[x4_new; y4_new;1];
%Normalized Points
x1_new_t=T_norm_new*x1_new_mat;
x2_new_t=T_norm_new*x2_new_mat;
x3_new_t=T_norm_new*x3_new_mat;
x4_new_t=T_norm_new*x4_new_mat;

%Create P matrix for homography for each point
p1=[-x1_t(1,1) -x1_t(2,1) -1 0 0 0 x1_new_t(1,1)*x1_t(1,1) x1_new_t(1,1)*x1_t(2,1) x1_new_t(1,1);
    0 0 0 -x1_t(1,1) -x1_t(2,1) -1 x1_t(1,1)*x1_new_t(2,1) x1_t(2,1)*x1_new_t(2,1) x1_new_t(2,1)];

p2=[-x2_t(1,1) -x2_t(2,1) -1 0 0 0 x2_new_t(1,1)*x2_t(1,1) x2_new_t(1,1)*x2_t(2,1) x2_new_t(1,1);
    0 0 0 -x2_t(1,1) -x2_t(2,1) -1 x2_t(1,1)*x2_new_t(2,1) x2_t(2,1)*x2_new_t(2,1) x2_new_t(2,1)];

p3= [-x3_t(1,1) -x3_t(2,1) -1 0 0 0 x3_new_t(1,1)*x3_t(1,1) x3_new_t(1,1)*x3_t(2,1) x3_new_t(1,1);
    0 0 0 -x3_t(1,1) -x3_t(2,1) -1 x3_t(1,1)*x3_new_t(2,1) x3_t(2,1)*x3_new_t(2,1) x3_new_t(2,1)];

p4= [-x4_t(1,1) -x4_t(2,1) -1 0 0 0 x4_new_t(1,1)*x4_t(1,1) x4_new_t(1,1)*x4_t(2,1) x4_new_t(1,1);
    0 0 0 -x4_t(1,1) -x4_t(2,1) -1 x4_t(1,1)*x4_new_t(2,1) x4_t(2,1)*x4_new_t(2,1) x4_new_t(2,1)];
P=[p1;p2;p3;p4];

%Calculating Vmatrix using Singular Value Decomposition
 [U,S,V]=svd(P);
%Homography vector is last column of V matrix

H=V(:,end);
h=vec2mat(H,3); %convert into matrix
h=inv(T_norm_new)*h; %Denormalize
%Bilinear Interpolation
for i=1:rows_new
    for j=1:cols_new
        for c=1:3
         X=[i;j;1];
         X_original=inv(h)*X;    
         %Multiplication of inverse h and new points gives original point
         X1_original=X_original/X_original(3,1); %Convert in homogenous
         X1_original=inv(T_norm)*X1_original; %Denormalize
    
      if(X1_original(1,1)>0&&X1_original(2,1)>0)
            
       x_true=floor(X1_original(1,1));
       y_true=floor(X1_original(2,1));
       
       %Conditions for boundary points
       x_true(x_true<1)=1;
       y_true(y_true<1)=1;
       x_true(x_true>size(I,1)-1)=size(I,1)-1;
       y_true(y_true>size(I,2)-1)=size(I,2)-1;
       a=X1_original(1,1)-x_true;
       b=X1_original(2,1)-y_true;
     %Bilinear formula  
     I_output(i,j,c)=(((1-a)*(1-b))*I(x_true,y_true,c))+((a*(1-b))*I(x_true+1,y_true,c))+((a*b)*I(x_true+1,y_true+1,c))+(((1-a)*b)*I(x_true,y_true+1,c)); %red value
         end
        end
    end
end
%Display image
figure, imshow(I_output);
