%reading images
clear
clear all
%reading multiple images from directory
image=dir('selected_fountain\*.png');
nfiles=length(image);
for i=1:nfiles
    current_name=strcat('selected_fountain\',image(i).name);
    current_image=imread(current_name); %reading all images
    images{i}=current_image;
end
%images{1} represents 1st image image{2} represents 2nd image i.e. refrenced
%one and images{3} represents 3rd image

%extract p matrice for each image
P=get_p_matrices();

%extract K,R,t matrices for each image
[K,R,t,img_dims]=extract_values_from_cam_matrix();

%recenter R and t with refrence image
[R,t, base_matrix]=recenter_camera_matrices(R,t);

%% evaluating planes for different depth

%depth range: 4.75 - 9.75

depth_range=numel(4.75:0.5:9.75);
H_cam1=zeros(3,3,depth_range);
H_cam2=zeros(3,3,depth_range);
i=0;
n=[0 0 -1]'; %for  frontoparallel
for d=4.75:0.5:9.75
    i=i+1;
    H_cam1(:,:,i)= compute_homography(K(:,:,2),K(:,:,1),R(:,:,1),t(:,:,1),n,d);
    H_cam2(:,:,i)= compute_homography(K(:,:,2),K(:,:,3),R(:,:,3),t(:,:,3),n,d);
end
%% for left oriented plane
n_left=R(:,:,1)'*n;

for d=4.75:0.5:9.75
    i=i+1;
    H_cam1(:,:,i)= compute_homography(K(:,:,2),K(:,:,1),R(:,:,1),t(:,:,1),n_left,d);
    H_cam2(:,:,i)= compute_homography(K(:,:,2),K(:,:,3),R(:,:,3),t(:,:,3),n_left,d);
end
%% for right oriented
n_right=R(:,:,3)'*n;

for d=4.75:0.5:9.75
    i=i+1;
    H_cam1(:,:,i)= compute_homography(K(:,:,2),K(:,:,1),R(:,:,1),t(:,:,1),n_right,d);
    H_cam2(:,:,i)= compute_homography(K(:,:,2),K(:,:,3),R(:,:,3),t(:,:,3),n_right,d);
end
%%  calulating warped images

for i=1:size(H_cam1,3)
warped_image_1{i}(:,:,:)=inv_warp_image(img_dims(1),img_dims(2),H_cam1(:,:,i),images{1});
warped_image_2{i}(:,:,:)=inv_warp_image(img_dims(1),img_dims(2),H_cam2(:,:,i),images{3});
end

%% show images

for i=1:size(H_cam1,3)
    figure
    
    imshow(uint8(warped_image_1{i}));
    figure
    imshow(uint8(warped_image_2{i}));
end
%% sad
left_sad=zeros(size(images{2},1),size(images{2},2),size(H_cam1,3));
right_sad=zeros(size(images{2},1),size(images{2},2),size(H_cam1,3));

for i=1:size(H_cam1,3)
    left_sad(:,:,i)=image_sad(double(warped_image_1{i}),double(images{2}),7);
    right_sad(:,:,i)=image_sad(double(warped_image_2{i}),double(images{2}),7);
end
%% min sad
final_sad=zeros(size(images{2},1),size(images{2},2),size(H_cam1,3));
frontoparallel=zeros(size(images{2},1),size(images{2},2),size(H_cam1,3)/3);
left_oriented=zeros(size(images{2},1),size(images{2},2),size(H_cam1,3)/3);
right_oriented=zeros(size(images{2},1),size(images{2},2),size(H_cam1,3)/3);
depth_mat_left=zeros(size(images{2},1),size(images{2},2),2);
depth_mat_center=zeros(size(images{2},1),size(images{2},2),2);
depth_mat_right=zeros(size(images{2},1),size(images{2},2),2);
depth_mat=zeros(imgdims(2),imgdims(1));

depth=[4.75:0.5:9.75];
final_sad = left_sad + right_sad;
%final=final_sad(:,:,1:11)+final_sad(:,:,12:22)+final_sad(:,:,23:33);
frontoparallel=final_sad(:,:,1:11);
left_oriented=final_sad(:,:,12:22);
right_oriented=final_sad(:,:,23:33);

for i=1:img_dims(2)
    for j=1:img_dims(1)
        [~, idx_f]=min(frontoparallel(i,j,:));
        depth_mat_left(i,j,1)=depth(idx_f);
        depth_mat_left(i,j,2)=pkrn(frontoparallel(i,j,:));

        [~, idx_l]=min(left_oriented(i,j,:));
        depth_mat_center(i,j,1)=depth_diagnoal_planes(depth(idx_l), K(:,:,2),n_left,i,j);
        %depth_mat_center(i,j,2)=pkrn(final_centerplane(i,j,:));

        [~, idx_r]=min(right_oriented(i,j,:));
         depth_mat_right(i,j,1)=depth_diagnoal_planes(depth(idx_r), K(:,:,2),n_right,i,j);
        %depth_mat_right(i,j,2)=pkrn(right_oriented(i,j,:));

    end
end
depth_mat=depth_calc(frontoparallel,left_oriented,right_oriented,imgdims);
figure
imshow(uint8(depth_mat*5))
title('Depth Map')
