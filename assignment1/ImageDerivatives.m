%% Function Question 5.4
function F = ImageDerivatives(im, sigma, type)
    if type == 'x'
        Gx = gaussianDer(sigma);
        F = conv2(im, Gx, 'same');
    elseif type == 'y'
        Gy = gaussianDer(sigma)';
        F = conv2(im, Gy, 'same');
    elseif type == 'xy'
        Gx = gaussianDer(sigma);
        Gy = gaussianDer(sigma)';
        F = conv2(Gx, Gy, im, 'same');
    elseif type == 'yx'
        Gy = gaussianDer(sigma)';
        Gx = gaussianDer(sigma);
        F = conv2(Gy, Gx, im, 'same');
    elseif type == 'xx'
        x = -3*sigma : 3*sigma;
        Gxx = (-sigma.^2 + x.^2) ./ (sigma.^4) .* gaussian(sigma);
        F = conv2(im, Gxx, 'same');
    elseif type == 'yy'
        y = -3*sigma : 3*sigma;
        Gyy = ((-sigma.^2 + y.^2) ./ (sigma.^4) .* gaussian(sigma))';
        F = conv2(im, Gyy, 'same');
    end
end