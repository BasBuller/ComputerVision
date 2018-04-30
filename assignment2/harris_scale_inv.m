function [rFin, cFin, sFin] = harris_scale_inv(im, sigma_range)

hsize       = [3, 3];
R_current   = 0;
siz         = size(im);
finalImage  = zeros(siz);
s           = zeros(siz);
sFin        = zeros(siz);

for sigma = sigma_range
    % Determine Laplacian for all different sigma values, check for corner
    % points at the keypoint locations from the Harris function.
    localImage      = zeros(size(im));
    
    [r, c] = harris(im, sigma);
    laplacian = imfilter(im, fspecial('log', [3, 3], sigma), 'replicate', 'same') .* (sigma^2);
%     min(min(laplacian))
%     max(max(laplacian))
    localImage(sub2ind(siz, r, c)) = laplacian(sub2ind(siz, r, c));
    
    [sRow, sCol] = find(abs(localImage) > finalImage);
    s(sub2ind(siz, sRow, sCol)) = sigma;
    
    finalImage = max(finalImage, abs(localImage));
end

finalClean = (imdilate(finalImage, strel('square', 3)) == finalImage & finalImage > 0);  %???
[rFin, cFin] = find(finalClean);
sFin = s(sub2ind(siz, rFin, cFin));

% showing = im;
% showing(finalClean==1) = 1;
% 
% figure()
% imshow(showing)

end