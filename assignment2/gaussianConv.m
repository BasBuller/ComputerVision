%% Function Question 2
function imOut = gaussianConv(image_path, sigma_x, sigma_y);
    im = imread(image_path);
    if size(im, 3) == 1
        im = im2double(im);
    else
        im = im2double(rgb2gray(im));
    end
    G_x     = gaussian(sigma_x);
    G_y     = gaussian(sigma_y);
    imOut   = imshow(conv2(G_y, G_x, im, 'same'));
end