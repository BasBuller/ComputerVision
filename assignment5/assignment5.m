% Script for assignment 5 of Computer Vision, the fundamental matrix and
% stereo vision.
% 
% Authors: Bas Buller & Rick Feith

close all; clear all; clc;


%% Run parameters
plt = 0;


%% Determine feature point descriptors and matches between images
tedLoc1     = './TeddyBearPNG/obj02_001.png';
tedLoc2     = './TeddyBearPNG/obj02_002.png';

ted1        = imread(tedLoc1);
ted2        = imread(tedLoc2);

% Descriptor files of teddy bear images
descFile1   = './TeddyBearPNG/obj02_001.png.haraff.sift';
descFile2   = './TeddyBearPNG/obj02_002.png.haraff.sift';


%% 
fundEstimation(descFile1, descFile2)