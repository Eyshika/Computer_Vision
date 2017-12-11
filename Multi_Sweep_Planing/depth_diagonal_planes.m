function depth=depth_diagonal_planes(d, K_ref, n, x, y)
%depth_diagonal_planes function is to get depth value fr oriented planes

depth=(-d)/([x y 1]*(inv(K))'*n);
end