function [ cams ] = get_cams()
%get_cams returns the camera values from the .camera files
cams = zeros(9,3,3);
% cams(:,:,1) = [2759.48 0 1520.69
%                 0 2764.16 1006.81
%                 0 0 1
%                 0 0 0
%                 0.450927 -0.0945642 -0.887537
%                 -0.892535 -0.0401974 -0.449183 
%                 0.00679989 0.994707 -0.102528
%                 -7.28137 -7.57667 0.204446
%                 3072 2048 0];
% cams(:,:,2) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.582226 -0.0983866 -0.807052 
% -0.813027 -0.0706383 -0.577925 
% -0.000148752 0.992638 -0.121118 
% -8.31326 -6.3181 0.16107 
% 3072 2048 0];
% cams(:,:,3) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.666779 -0.0831384 -0.740603 
% -0.74495 -0.0459057 -0.665539 
% 0.021334 0.99548 -0.0925429 
% -9.46627 -5.58174 0.147736 
% 3072 2048 0];
% cams(:,:,4) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.795163 -0.050195 -0.604314 
% -0.606377 -0.0736593 -0.791759 
% -0.00477103 0.996019 -0.0890082 
% -10.8142 -4.53704 0.122293 
% 3072 2048 0];
cams(:,:,1) = [2759.48 0 1520.69; 
0 2764.16 1006.81; 
0 0 1; 
0 0 0;
0.890856 -0.0211638 -0.453793; 
-0.454283 -0.0449857 -0.889721; 
-0.00158434 0.998763 -0.0496901; 
-12.404 -3.81315 0.110559 ;
3072 2048 0];
cams(:,:,2) = [2759.48 0 1520.69 ;
0 2764.16 1006.81 ;
0 0 1 ;
0 0 0;
0.962742 -0.0160548 -0.269944; 
-0.270399 -0.0444283 -0.961723 ;
0.00344709 0.998884 -0.0471142; 
-14.1604 -3.32084 0.0862032; 
3072 2048 0];
cams(:,:,3) = [2759.48 0 1520.69; 
0 2764.16 1006.81 ;
0 0 1; 
0 0 0;
0.994915 -0.00462005 -0.100616 ;
-0.100715 -0.0339759 -0.994335; 
0.00117536 0.999412 -0.0342684; 
-15.8818 -3.15083 0.0592619; 
3072 2048 0];
% cams(:,:,3) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.995535 0.003721 0.0943235 
% 0.0943815 -0.02118 -0.995311 
% -0.00170578 0.999769 -0.0214366 
% -17.6302 -3.36186 0.0325247 
% 3072 2048 0];
% 
% cams(:,:,9) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.928942 0.000956298 0.370223 
% 0.370116 -0.0265758 -0.928605 
% 0.00895096 0.999646 -0.0250414 
% -19.6309 -3.81958 -0.00781603 
% 3072 2048 0];
% 
% cams(:,:,10) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.84137 0.00860137 0.540391 
% 0.540262 -0.0403709 -0.840528 
% 0.0145864 0.999148 -0.0386139 
% -20.9553 -4.61897 -0.0303931 
% 3072 2048 0];
% 
% cams(:,:,11) = [2759.48 0 1520.69 
% 0 2764.16 1006.81 
% 0 0 1 
% 0 0 0
% 0.70735 0.0218279 0.706526 
% 0.706534 -0.0523403 -0.705741 
% 0.0215749 0.998391 -0.0524451 
% -21.9937 -5.82033 -0.0463931 
% 3072 2048 0];




end

