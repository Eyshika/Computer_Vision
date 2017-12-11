function [ projected_points ] = project_points_into_camera_space( points, R, t )
%project_points_in_space Given a 4xn matrix of points in world space and
%the R, t values of a camera, convert the points to a nx4 matrix in camera
%coordinate space
[dim, num_points] = size(points);
transform_matrix = zeros(4,4);
transform_matrix(1:3,1:3) = R;
transform_matrix(1:3,4) = t;
transform_matrix(4,4) = 1;
projected_points = transform_matrix * points;

for i = 1:num_points
    projected_points(:, i) = projected_points(:,i) / projected_points(4,i);
end
end

