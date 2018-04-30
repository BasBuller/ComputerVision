%% Function Question 5
function [magnitude, orientation] = gradmag(image_path, sigma_x, sigma_y)
    im = imread(image_path);
    if size(im, 3) == 1
        im = im2double(im);
    else
        im = im2double(rgb2gray(im));
    end

    Gd_x        = gaussianDer(sigma_x);
    Gd_y        = gaussianDer(sigma_y)';
    
    gd_im_x     = conv2(im, Gd_x, 'same');
    gd_im_y     = conv2(im, Gd_y, 'same');
    
    magnitude   = sqrt(gd_im_x.^2 + gd_im_y.^2);
    orientation = atan(gd_im_y./gd_im_x);
    
    figure('Name', 'Quiver')
    quiver(gd_im_x, gd_im_y)
end