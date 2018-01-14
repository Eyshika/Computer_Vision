%Created by Eyshika Agarwal
% reference: http://ais.informatik.uni-freiburg.de/teaching/ws11/robotics2/pdfs/rob2-08-camera-calibration.pdf
% Camera Calibration

% 1 cm	37.795275590551 pixel (X)
%converting cm to pixels

x_orig=floor(27*37.795275590551);
y_orig=floor(16.5*37.795275590551);
M_cordinate=[0 y_orig 1;x_orig y_orig 1;x_orig 0 1;0,0 1];
M_cordinate=M_cordinate';
im2=imread('IMG_1782.JPG');
imshow(im2);
[x,y]=ginput(4); %taking corner points of court with mouse click
m_cordinate_2=[x y ones(4,1)];
m_cordinate_2=m_cordinate_2';
H_2=homography2d(M_cordinate,m_cordinate_2)
H_2=H_2/H_2(3,3);

%% for IMG_1783
im3=imread('IMG_1783.JPG');
imshow(im3);
[x,y]=ginput(4);
m_cordinate_3=[x y ones(4,1)];
m_cordinate_3=m_cordinate_3';
H_3=homography2d(M_cordinate,m_cordinate_3)
H_3=H_3/H_3(3,3)

%% for IMG_1784
im4=imread('IMG_1784.JPG');
imshow(im4);
[x,y]=ginput(4);
m_cordinate_4=[x y ones(4,1)];
m_cordinate_4=m_cordinate_4';
H_4=homography2d(M_cordinate,m_cordinate_4)
H_4=H_4/H_4(3,3)

%% Compute K matrix

v_2=[compute_v_ij(H_2,1,2)'; (compute_v_ij(H_2,1,1)-compute_v_ij(H_2,2,2))']%im2
v_3=[compute_v_ij(H_3,1,2)'; (compute_v_ij(H_3,1,1)-compute_v_ij(H_3,2,2))']%im3
v_4=[compute_v_ij(H_4,1,2)'; (compute_v_ij(H_4,1,1)-compute_v_ij(H_4,2,2))']%im4
V=[v_2;v_3;v_4]
[U,S,Val]=svd(V);
b=Val(:,end)'
B11=b(1,1); B12=b(1,2); B22=b(1,3); B13=b(1,4); B23=b(1,5); B33=b(1,6)
B=[B11 B12 B13;...
    B12 B22 B23;...
    B13 B23 B33] %symmetric
disp(B);
v_0=(B12*B13-B11*B23)/(B11*B22-B12^2); %optical center
lambda=B33-(B13^2+v_0*(B12*B13-B11*B23))/B11
alpha=sqrt(lambda/B11)
beta=sqrt(lambda*B11/(B11*B22-B12^2))
gamma=-B12*alpha^2*beta/lambda
u_0=-B13*alpha/lambda;

K_Matrix = [alpha, gamma, u_0;...
    0, beta, v_0;...
    0, 0, 1]

%% Compute R and T Matrix

%R and t Matrix computation
[R_2,t_2]=computeRT(H_2,K_Matrix)
R_2'*R_2 %Not an identity matrix
[R_3,t_3]=computeRT(H_3,K_Matrix)
R_3'*R_3 %Not an identity matrix
[R_4,t_4]=computeRT(H_4,K_Matrix)
R_4'*R_4 %Not an identity matrix

%Alternate method
R_better_2=AlternateR(R_2)
R_better_2'*R_better_2 %Enforce identity matrix
R_better_3=AlternateR(R_3)
R_better_3'*R_better_3 %Enforce identity matrix
R_better_4=AlternateR(R_4)
R_better_4'*R_better_4 %Enforce identity matrix

%% Camera positions
%location=-R'*t

[~, camera_pose_2] = extrinsicsToCameraPose(R_better_2, ...
  t_2)
[~, camera_pose_3] = extrinsicsToCameraPose(R_better_3, ...
  t_3)
[~, camera_pose_4] = extrinsicsToCameraPose(R_better_4, ...
  t_4)