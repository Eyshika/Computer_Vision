clear;
%reading silhottes images from folder
image_sil=dir('*.pbm');
nfiles_sil=length(image_sil);
for i=1:nfiles_sil
    current_name=image_sil(i).name;
    current_image=imread(current_name); %reading all silhouttes
    images{i}=current_image;
end

%reading original images from folder
image=dir('*.png');
nfiles=length(image);
for i=1:nfiles
    current_name=image(i).name;
    current_image=imread(current_name); %reading all silhouttes
    images_orig{i}=current_image;
end

%initializing axis values
voxel=[];
xlim=-2.5:2.5;
ylim=-3:3;
zlim=0:2.5;
 total_voxels=10000000;
 volume=numel(xlim)*numel(ylim)*numel(zlim);
 volume=volume/total_voxels;
 side=nthroot(volume,3);

X=xlim(1):side:xlim(end); Y=ylim(1):side:ylim(end); Z=zlim(1):side:zlim(end);
voxel=nan(size(X,2), size(Y,2), size(Z,2)); %initializing matrix of voxel
color_voxel=nan(numel(voxel),3); %initialising matrix of color values for each point
%Xdata=x(:); Ydata=y(:); Zdata=z(:);

%% Calculating P from camera matrix

rawP = [776.649963  -298.408539 -32.048386  993.1581875 132.852554  120.885834  -759.210876 1982.174000 0.744869  0.662592  -0.078377 4.629312012;
431.503540  586.251892  -137.094040 1982.053375 23.799522   1.964373    -657.832764 1725.253500 -0.321776 0.869462  -0.374826 5.538025391;
-153.607925 722.067139  -127.204468 2182.4950   141.564346  74.195686   -637.070984 1551.185125 -0.769772 0.354474  -0.530847 4.737782227;
-823.909119 55.557896   -82.577644  2498.20825  -31.429972  42.725830   -777.534546 2083.363250 -0.484634 -0.807611 -0.335998 4.934550781;
-715.434998 -351.073730 -147.460815 1978.534875 29.429260   -2.156084   -779.121704 2028.892750 0.030776  -0.941587 -0.335361 4.141203125;
-417.221649 -700.318726 -27.361042  1599.565000 111.925537  -169.101776 -752.020142 1982.983750 0.542421  -0.837170 -0.070180 3.929336426;
94.934860   -668.213623 -331.895508 769.8633125 -549.403137 -58.174614  -342.555359 1286.971000 0.196630  -0.136065 -0.970991 3.574729736;
452.159027  -658.943909 -279.703522 883.495000  -262.442566 1.231108    -751.532349 1884.149625 0.776201  0.215114  -0.592653 4.235517090];


P = zeros(3,4,8);

for i=1:8
    for j=1:3
        P(j,1:4,i) = rawP(i,4*(j-1)+1:4*(j-1)+4);
    end
end

% P is the camera matrix
[h,w,d]=size(images_orig{1});
%% %% 
%checking image cordinates
for im=1:8
    for i=1:numel(X)
        for j=1:numel(Y)
            for k=1:numel(Z)
                %Mutiplication of Projection matrix with world coordinate
                %gives image cordinate
                image_cord=P(:,:,im)*[X(i);Y(j);Z(k);1];
                image_cord=image_cord./image_cord(3); %convert in homogenous cordinates
                
                %checking range constraints
                if (image_cord(1)<=w) && (image_cord(2)<=h) && (image_cord(1)>=1) && (image_cord(2)>=1)
                    if im==1
                    voxel(i,j,k)=images{im}(floor(image_cord(2)),floor(image_cord(1)));
                    color_voxel(sub2ind(size(voxel),i,j,k),:)=images_orig{im}(floor(image_cord(2)),floor(image_cord(1)),:);
                    else
                        if voxel(i,j,k)==1
                            voxel(i,j,k)=images{im}(floor(image_cord(2)),floor(image_cord(1)));
                            color_voxel(sub2ind(size(voxel),i,j,k),:)=images_orig{im}(floor(image_cord(2)),floor(image_cord(1)),:);
                        end
                    end
                    
                end
            end
        end
    end
end
%%  Visualisation
figure;

 voxel(voxel == 0) = nan;

h = slice(voxel, 1:size(voxel,1), 1:size(voxel,2), 1:size(voxel,3));

set(h, 'EdgeColor','none', 'FaceColor','interp')

alpha(0.1)

%% Writing ply file 
points=find(voxel==1);
colors=color_voxel(points,:);
[X1,X2,X3]=ind2sub(size(voxel),points);
data=[X(X1)' ,Y(X2)', Z(X3)'];
ptCloud=pointCloud(data);
ptCloud.Color=uint8(colors); %adding color values in ply file
pcwrite(ptCloud,'object3d.ply','Encoding','ascii');
pc = pcread('object3d.ply');
pcshow(pc); 
%% 

 