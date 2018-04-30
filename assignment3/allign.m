function [T, Tinv] = allign(ima, imb, P, threshold, N, amount, plot)
% File Name: align.m
% Author: Bas Buller
%
% Script to determine the affine transformation between two images.
% 1: Detect interest points
% 2: Find Matches
% 3: Use RANSAC to find transformation

% run('/home/bas/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup');
%run('C:\Users\Bas\Documents\MATLAB\vlfeat-0.9.21\toolbox\vl_setup');
run('../vlfeat-0.9.21-bin/vlfeat-0.9.21/toolbox/vl_setup')

%% Load Images
ima = readImage(ima);
imb = readImage(imb);


%% 1.
[framesA, descA]    = vl_sift(ima);
[framesB, descB]    = vl_sift(imb);
[matches]           = vl_ubcmatch(descA, descB);
xa                  = framesA(1, (matches(1,:)));
ya                  = framesA(2, (matches(1,:)));
xb                  = framesB(1, (matches(2,:)));
yb                  = framesB(2, (matches(2,:)));


%% RANSAC
N
[inliers, totalInliers, x] = RANSAC(P, xa, ya, xb, yb, threshold);

% transform   = [x(1) x(2); x(3) x(4)] * [xa; ya] + [x(5); x(6)];
xt          = [x(1) x(2)] * [xa; ya] + x(5);
yt          = [x(3) x(4)] * [xa; ya] + x(6);


%% Plotting Connections
if plot(1) == 1
    plotting(ima, imb, xa(1:amount), ya(1:amount), xb(1:amount), yb(1:amount))
end

if plot(2) == 1
    plotting(ima, imb, xa(1:amount), ya(1:amount), xt(1:amount), yt(1:amount))
end


%% Transform images
T                   = [x(1) x(2) x(5);
                        x(3) x(4) x(6);
                        0    0    1];
Tinv                = inv(T);



%% Plotting Transformed Images
if plot(3) == 1
    tform               = maketform('affine', T');
    image1_transformed  = imtransform(ima, tform, 'bicubic');

    tform               = maketform('affine', inv(T)');
    image2_transformed  = imtransform(imb, tform, 'bicubic');
    figure('name','t')
    imshow(image2_transformed)
    figure()
    subplot(2, 2, 1)
    imshow(ima)
    subplot(2, 2, 2)
    imshow(imb)
    subplot(2, 2, 3)
    imshow(image2_transformed)
    subplot(2, 2, 4)
    imshow(image1_transformed)
end


%%
save data.mat


end