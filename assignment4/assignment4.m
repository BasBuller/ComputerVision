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
plt         = 0;                    % set 1 to generate plot, set 0 for nothing


%% Basic Optical Flow between 2 images
[FSphere, indSphere]    = optflowBasic(sphere1, sphere2, sigma, spacing, plt);
[FSynth, indSynth]      = optflowBasic(synth1, synth2, sigma, spacing, plt);


%% Read House Images
plt            = 0;
[truePts, truePtsC]     = readMatrix();

for i = 1:101
    imLoc       = ['model_house/frame' num2str(i, '%08d') '.jpg'];
    im          = readImage(imLoc);
    if i == 1
        imF     = zeros(size(im, 1), size(im, 2), 101);
    end
    imF(:,:,i)  = im;
end


%% Optical Flow Tracking of House Images
[pointsx, pointsy]    = optflowTracking(imF, truePts, sigma, plt);

LS  = zeros(1, size(imF, 3)-1);
x   = 1:(size(imF, 3)-1);
for i = 1:size(imF, 3)-1
    dis_x = pointsx(i, :) - truePts(2*i-1, :);
    dis_y = pointsy(i, :) - truePts(2*i, :);
    eudis=(dis_x).^2+(dis_y).^2;
    LS(i)=sqrt(sum(eudis,2));
end

figure()
plot(x, LS)
xlabel('image #')
ylabel('sum of LS-error')


%% Structure from Motion
% Generate complete D matrix with interest points from LKtracker
hFlw    = size(pointsx, 1) + size(pointsy, 1);
wFlw    = size(pointsy, 2);
flwPts  = zeros(hFlw, wFlw);
    
flwPts(1:2:end, :)  = pointsx;
flwPts(2:2:end, :)  = pointsy;

% Determine SfM plot for flow points and ground truth
Sflw              = SfM(flwPts);
Strue             = SfM(truePts);

figure()
plot3(Strue(1,:), Strue(2,:), Strue(3,:), '.g')
hold on
plot3(Sflw(1,:), Sflw(2,:), Sflw(3,:), '.r')










