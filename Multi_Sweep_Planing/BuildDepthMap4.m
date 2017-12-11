load data.mat
p_mats = get_p_matrices();
P4 = p_mats(:,:,4);
cam_mats = get_cams();
[K4, R4, c4, dims4] = extract_values_from_cam_matrix(cam_mats(:,:,4));
t4 = (-1) * R4 * c4;

% Get Background Points
foreground_pts = ForegroundPointCloudRGB(1:3, :);
[fsize, num_pts] = size(foreground_pts);
filler = ones(1, num_pts);
foreground_pts = vertcat(foreground_pts, filler);
projected_pts = project_points_into_camera_space(foreground_pts, R4, t4);
d_map = construct_depth_map(foreground_pts, projected_pts, dims4(2), dims4(1), P4);
imshow(d_map / 255);