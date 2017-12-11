function [ H ] = compute_homography( K1, K2, R, t, n, d)
%compute_homography Given K1 for a base camera, K2 for a second camera, R,
%t, normal, and d values, compute the Homography Matrix that serves a
%homography from image 1 to image 2



 H = K2 * (R - (t * n') / d) / K1;
 H = H / H(3,3);

end