function [ warped_image ] = inv_warp_image(width, height, H, img)
%inv_warp_image Given an original image width and height, an H matrix, and
%an image being warped to, compute the inverse warping over the image
%   This should be used directly using the H calculated from eqn (13.2)
%   And the secondary image being 'warped' from

[img_height, img_width, colors] = size(img);
warped_image = zeros(height,width,colors);

for x = 1:width
    for y = 1:height
        warped_point = H * [x,y,1]';
        warped_point = warped_point / warped_point(3);
        
        warped_x = warped_point(1);
        warped_y = warped_point(2);
        
        if warped_x < 1 || warped_x > img_width
            continue
        end
        if warped_y < 1 || warped_y > img_height
            continue
        end
        
        % Use Bilinear Interpolation to get color
        min_x = floor(warped_x);
        max_x = ceil(warped_x);
        x_prop = mod(warped_x, 1);
        
        min_y = floor(warped_y);
        max_y = ceil(warped_y);
        y_prop = mod(warped_y, 1);
        
        final_color = [0,0,0]';
        final_color = final_color + x_prop * y_prop * reshape(double(img(max_y,max_x,:)), [3,1]);
        final_color = final_color + (1-x_prop) * y_prop * reshape(double(img(max_y,min_x,:)), [3,1]);
        final_color = final_color + x_prop * (1-y_prop) * reshape(double(img(min_y,max_x,:)), [3,1]);
        final_color = final_color + (1-x_prop) * (1-y_prop) * reshape(double(img(min_y,min_x,:)), [3,1]);

        warped_image(y,x,:) = final_color;
        
    end
end



end

