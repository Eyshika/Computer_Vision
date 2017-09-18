
Direct Linear transformation follows Homography estimation.

Objective
Given n≥4 2D to 2D point correspondences {xi↔xi’},
determine the 2D homography matrix H such that xi’=Hxi
Algorithm
(i) For each correspondence xi ↔xi’ compute Ai. Usually
only two first rows needed.
(ii) Assemble n 2x9 matrices Ai into a single 2nx9 matrix A
(iii) Obtain SVD of A. Solution for h is last column of V
(iv) Determine H from h

where x are original coordinates needs to be projected and x' are new coordinates where image needs to be projected.

Basketball-court is the original image which has been projected.
Output is the new image formed using DLT and Bilinear Interpolation.
