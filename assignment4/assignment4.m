% Computer Vision Assignment 4 - Optical Flow
% Bas Buller & Rick Feith

close all; clear all; clc;


%% Initialize parameters
sphere1     = 'sphere1.ppm';
sphere2     = 'sphere2.ppm';
synth1      = 'synth1.pgm';
synth2      = 'synth2.pgm';

sigma       = 1;                    % Sigma value for the derivative filter
spacing     = 15;                   % Size of square patches for optical flow
plot        = 0;                    % set 1 to generate plot, set 0 for nothing


%% Basic Optical Flow between 2 images
[FSphere, indSphere]    = optflowBasic(sphere1, sphere2, sigma, spacing, plot);
[FSynth, indSynth]      = optflowBasic(synth1, synth2, sigma, spacing, plot);


%% Optical Flow Tracking of House Images
plot            = 1;
[truePts, truePtsC]     = readMatrix();

for i = 1:101
    imLoc       = ['model_house/frame' num2str(i, '%08d') '.jpg'];
    im          = readImage(imLoc);
    if i == 1
        imF     = zeros(size(im, 1), size(im, 2), 101);
    end
    imF(:,:,i)  = im;
end

[ptsX, ptsY]    = optflowTracking(imF, truePts, sigma, plot);


%% Structure from Motion
% Generate complete D matrix with interest points from LKtracker
hFlw    = size(ptsX, 1) + size(ptsY, 1);
wFlw    = size(ptsX, 2);
flwPts  = zeros(hFlw, wFlw);
    
flwPts(1:2:end, :) = ptsX;
flwPts(2:2:end, :) = ptsY;

% Determine SfM plot for flow points and ground truth
% plot = 1
% 
% SfM(truePtsC, plot);