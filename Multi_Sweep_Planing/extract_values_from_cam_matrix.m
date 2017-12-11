function [ K, R, t, img_dims ] = extract_values_from_cam_matrix()
%Given a matrix formatted from get_cams,
%   Return the values contained in that matrix

cams = get_cams();

K = zeros(3,3,3);
R = zeros(3,3,3);
t = zeros(3,1,3);

for i=1:3
    K(:,:,i) = cams(1:3,:,i);
    R(:,:,i) = cams(5:7,:,i)';
    t(:,:,i) = (-1) * R(:,:,i) * cams(8,:,i)';
end

img_dims = cams(9,:,1)';




end

