% Assignment 2.1 Computer Vision
% Bas Buller
% 05-02-2018

close all; clc; clear all;
run('/home/bas/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup');


%% images and parameters

color_a     = imread('landscape-a.jpg');
color_b     = imread('landscape-b.jpg');

land_a      = im2double(rgb2gray(imread('landscape-a.jpg')));
land_b      = im2double(rgb2gray(imread('landscape-b.jpg')));

land_a_s    = im2single(rgb2gray(imread('landscape-a.jpg')));
land_b_s    = im2single(rgb2gray(imread('landscape-b.jpg')));

sigma_range = 1.2.^(0:12);
threshold   = 0.8;


%% Determine scale invariant Harris function

[r_a, c_a, s_a] = harris_scale_inv(land_a, sigma_range);
[r_b, c_b, s_b] = harris_scale_inv(land_b, sigma_range);


%% Determine Euclidian distance based on SIFT classification

[f_a, d_a]      = vl_sift(land_a_s, 'frames', [[c_a]'; [r_a]'; [2.*s_a+1]'; [zeros(size(s_a))]'], 'orientations');
[f_b, d_b]      = vl_sift(land_b_s, 'frames', [[c_b]'; [r_b]'; [2.*s_b+1]'; [zeros(size(s_b))]'], 'orientations');

[match, scores] = vl_ubcmatch(d_a, d_b, 1.);


%% Plot Results
figure()
imshow([color_a, color_b])
hold on
scatter(f_a(1, match(1, :)), f_a(2, match(1, :)), 'r')
hold on
scatter(size(land_a, 2) + f_b(1, match(2, :)), f_b(2, match(2, :)), 'r')
hold on
% line([f_a(1, match(1, :)); size(land_a, 2) + f_b(1, match(2,:))], [f_a(2, match(1,:)); f_b(2, match(2, :))])






%% OLD CODE 
% [f_a, d_a]      = vl_sift(single(land_a));
% [f_b, d_b]      = vl_sift(single(land_b));
% [match, scores] = vl_ubcmatch(d_a, d_b);


% f_a = double(f_a);
% d_a = double(d_a);
% f_b = double(f_b);
% d_b = double(d_b);
% 
% da2 = d_a.^2;
% db2 = d_b.^2;
% dab = d_a'*d_b;
% dists = sqrt(sum(da2, 1)' - 2.*dab + sum(db2, 1));
% 
% [nnb, indTot]   = mink(dists, 2, 2);
% ratios          = nnb(:, 1) ./ nnb(:, 2);
% mask            = ratios < threshold;
% 
% cTrue           = indTot(mask, 1);
% rTrue           = find(mask);

%% Plot shared keypoints on both images
% 
% figure('Name', 'Landscape A')
% imshow(color_a)
% hold on
% scatter(c_a(match(1,:)), r_a(match(1,:)), 'b')
%
% 
% figure('Name', 'Landscape B')
% imshow(color_b)
% hold on
% scatter(c_b(match(2,:)), r_b(match(2,:)), 'b')


%% Trial
% figure('Name', 'Landscape A')
% imshow(land_a)
% hold on
% scatter(f_a(1, match(1, :)), f_a(2, match(1, :)), 'r')
% 
% 
% figure('Name', 'Landscape B')
% imshow(land_b)
% hold on
% scatter(f_b(1, match(2, :)), f_b(2, match(2, :)), 'r')



