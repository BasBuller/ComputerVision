
% Assignment 3 Computer Vision
% Author: Bas Buller

close all; clc; clear all;


%% Load Images
im1     = 'img1.pgm';
im2     = 'img2.pgm';
im3     = 'img3.pgm';
im4     = 'img4.pgm';
im5     = 'img5.pgm';
im6     = 'img6.pgm';

left    = 'left.jpg';
right   = 'right.jpg';


%% Image allignment
P           = 3;
threshold   = 10;
N           = 1000;
amountPlot  = 15;
plot        = [0, 0, 0];

[T, Tinv] = allign(left, right, P, threshold, N, amountPlot, plot);


%% Stitching
plotStitch  = 1;
floors      = 1;
color       = 1;
[c1,c2,c3,c4]   = stitching(left, right, Tinv, plotStitch, floors,color);
load stitch.mat

