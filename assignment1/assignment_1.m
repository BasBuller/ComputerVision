% Assignment 1 Computer Vision


%% Assign values to parameters
sigma_x     = 2;                                            % standard deviation x direction
sigma_y     = 2;                                            % standard deviation y direction
sigma_m     = 1;                                            % sigma for imgausfit function
stripes     = 'pn1.jpg';                                    % stripes image
zebra       = 'zebra.png';                                  % zebra image
threshold   = 0.1;                                          % percentage of maximum value
imp_size    = 25;                                           % number of values per dimension, e.g. pixels


%% Plot Gaussian Filtered Images
figure('Name', 'Stripes')

subplot(2, 3, 1)
imshow('pn1.jpg')
title('Original stripes')

subplot(2, 3, 2)
gaussianConv(stripes, sigma_x, sigma_y);
title('Own stripes')

subplot(2, 3, 3)
imshow(imgaussfilt(imread(stripes), sigma_m));
title('Matlab stripes')

subplot(2, 3, 4)
imshow('zebra.png')
title('Original zebra')

subplot(2, 3, 5)
gaussianConv(zebra, sigma_x, sigma_y);
title('Own zebra')

subplot(2, 3, 6)
imshow(imgaussfilt(imread(zebra), sigma_m));
title('Matlab zebra')



%% Plot Gaussian Derivative Filtered Images
[magnitude_str, orientation_str] = gradmag(stripes, sigma_x, sigma_y);
[magnitude_zebra, orientation_zebra] = gradmag(zebra, sigma_x, sigma_y);

figure('Name', 'Derivatives')

subplot(2, 2, 1)
imshow(magnitude_str, [])
colormap(hsv);
colorbar;
title('Magnitude Stripes')

subplot(2, 2, 2)
imshow(orientation_str, [-pi, pi])
colormap(hsv);
colorbar;
title('Orientation Stripes')

subplot(2, 2, 3)
imshow(magnitude_zebra, [])
colormap(hsv);
colorbar;
title('Magnitude Zebra')

subplot(2, 2, 4)
imshow(orientation_zebra, [-pi, pi])
colormap(hsv);
colorbar;
title('Orientation Zebra')


%% Plot Gaussian Derivative with Magnitude Threshold
thresh_str      = max(max(magnitude_str))*threshold;
thresh_zebra    = max(max(magnitude_zebra))*threshold;

figure('Name', 'Threshold Magnitudes')

subplot(2, 1, 1)
imshow(magnitude_str, [(thresh_str - 0.00001) thresh_str])
colormap(hsv);
colorbar;
title('Stripes')

subplot(2, 1, 2)
imshow(magnitude_zebra, [(thresh_zebra - 0.00001) thresh_zebra])
colormap(hsv);
colorbar;
title('Zebra')


%% Question 5.5
imp                     = zeros(imp_size, imp_size);
center                  = ceil(imp_size/2);
imp(center, center)     = 255;

derivatives             = ["x", "y", "xy", "yx", "xx", "yy"];

figure('Name', 'Impulse Convolutions')
for i = 1:length(derivatives)
    subplot(2, 3, i)
    imshow(ImageDerivatives(imp, sigma_m, derivatives(i)), []);
    title(derivatives(i));
end










