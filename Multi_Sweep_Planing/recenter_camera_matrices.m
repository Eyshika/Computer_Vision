function [R, t, base_matrix]=recenter_camera_matrices(R,t)


%assuming 2nd image as refrenced image 

refrence=[R(:,:,2) t(:,:,2);
          zeros(1,size(R,2))  ones(1,size(t,2))];
refrence_matrix=inv(refrence);

%checking refrence image
base_matrix=refrence*refrence_matrix;


%for camera 1
camera_1=[R(:,:,1) t(:,:,1);
         zeros(1,size(R,2)) ones(1,size(t,2))];
camera_matrices=camera_1*refrence_matrix;
R(:,:,1)=camera_matrices(1:3,1:3);
t(:,:,1)=camera_matrices(1:3,4);


%for camera 3
camera_3=[R(:,:,3) t(:,:,3);
         zeros(1,size(R,2)) ones(1,size(t,2))];
camera_matrices=camera_3*refrence_matrix;
R(:,:,3)=camera_matrices(1:3,1:3);
t(:,:,3)=camera_matrices(1:3,4);

end