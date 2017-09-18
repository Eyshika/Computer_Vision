clc;
clear all;
prompt='Enter sigma value=';
sigma=input(prompt);
I=imread('G:\stevens\558\homeworks\plane.pgm');
figure, imshow(I);
title('Original Image');

[dir,mag]=Filtering(I,sigma);
figure,imshow(mag);
title('Sobel gradient with Threshold');

newdir=NMS(mag,dir);
figure, imshow(newdir);
title('Non maximum Suppression');


   
        