% [x, y, a, b, c, desc ] = 
clear
run('../vlfeat-0.9.21/toolbox/vl_setup')
%% read images and find sift features
im1 = './TeddyBearPNG/obj02_001.png';
im2 = './TeddyBearPNG/obj02_002.png';
% command = '/home/rick/Documents/extract_features/extract_features.ln -haraff -i ./TeddyBearPNG/obj02_001.png -sift';
% system(command)
% command = '/home/rick/Documents/extract_features/extract_features.ln -haraff -i ./TeddyBearPNG/obj02_002.png -sift';
% system(command)

%% read descriptor file to find location and desriptor
im1txt = './TeddyBearPNG/obj02_001.png.haraff.sift';
im2txt = './TeddyBearPNG/obj02_002.png.haraff.sift';

[x1 y1 a1 b1 c1 desc1] =loadFeatures(im1txt);
[x2 y2 a2 b2 c2 desc2] =loadFeatures(im2txt);

%% show feature points
% figure()
% imshow(im1)
% hold on
% scatter(x1,y1)
% 
% figure()
% imshow(im2)
% hold on
% scatter(x2,y2)


%% match descriptors
[matches, scores] = vl_ubcmatch (desc1' , desc2');

match1 = matches(1,:);
match2 = matches(2,:);
x1m  = x1(match1(:));
y1m  = y1(match1(:));
x2m  = x2(match2(:));
y2m  = y2(match2(:));

%% find fundamental matrix

[F] = fundamentalMatrix(x1m,y1m,x2m,y2m);
%% Normalize data
[x1n,y1n,T1] = normalize(x1,y1);

[x2n,y2n,T2] = normalize(x2,y2);

x1nm  = x1n(match1(:));
y1nm  = y1n(match1(:));
x2nm  = x2n(match2(:));
y2nm  = y2n(match2(:));


[average1, dist1] = check_normalize(x1n,y1n);
[average2, dist2] = check_normalize(x2n,y2n);


%% calculate normalized fundamental matrix
[Fn] = fundamentalMatrix(x1nm,y1nm,x2nm,y2nm);

%% Denormalize
FD = T2' * Fn * T1; 

%% RANSAC

[F,test] = fundamentalRansac(x1nm, y1nm, x2nm, y2nm, 1000, 1);
FRD = T2' * F * T1; 

% (diag([x2 y2 ones(size(x2))]*F*[x1 y1 ones(size(x1))]'))

[lines] = epipolarLines(FRD, [x1nm(test),y1nm(test)]);