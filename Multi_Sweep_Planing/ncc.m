function [ ncc_val ] = ncc( patch_1, patch_2 )
%Given two image patches of equal dimension, calculate and return the NCC
%   Between the two patches


for i=1:3
    patch_1_separate{i}(:,:)=patch_1(:,:,i);
    patch_2_separate{i}(:,:)=patch_2(:,:,i);
    m1(i) = mean(patch_1_separate{i}(:));
    s1(i) = std(patch_1_separate{i}(:));
    m2(i) = mean(patch_2_separate{i}(:));
    s2(i) = std(patch_2_separate{i}(:));

    normalized_patch_1(:,:,i) = (patch_1_separate{i} - m1(i)) / s1(i);
    normalized_patch_2(:,:,i) = (patch_2_separate{i} - m2(i)) / s2(i);

    prod(:,:,i) = normalized_patch_1(:,:,i) .* normalized_patch_2(:,:,i);
    prod_vec=prod(:,:,i);
    ncc_val(i) = sum(prod_vec(:));

end

