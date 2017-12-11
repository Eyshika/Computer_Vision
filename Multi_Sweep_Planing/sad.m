function [ dist ] = sad( patch_1, patch_2 )
%sad return the sum of absolute differences between patches
dist = abs(patch_1 - patch_2);
dist = sum(dist(:));

end

