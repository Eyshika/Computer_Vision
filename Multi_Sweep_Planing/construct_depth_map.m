function [ depth_map ] = construct_depth_map( points_world, points_camera, img_height, img_width, P )
%construct_depth_map Given poitns in world space and camera space, and
%image height, width, and projection matrix,
%   Construct a depth map by projecting points into the image and utilizing
%   their depth
[dim, num_points] = size(points_world);
depth_map = ones(img_height, img_width) * 255;
fully_projected_points = P * points_world;

for i = 1:num_points
   fully_projected_points(:, i) = fully_projected_points(:, i) / fully_projected_points(3, i);
   pt = round(fully_projected_points(1:2, i));
   u = pt(1);
   v = pt(2);
   
   if u < 1 || u > img_width
       continue
   end
   if v < 1 || v > img_height
       continue
   end
   
   depth = points_camera(3, i);
   if depth < depth_map(v,u)
       depth_map(v,u) = depth;
   end
end

