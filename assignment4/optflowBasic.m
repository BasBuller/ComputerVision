% Basic optic flow between just two images.
% Authors: Bas Buller & Rick Feith

function [F, ind] = optflowBasic(im1, im2, sigma, spacing, plot) 
im1         = readImage(im1);
im2         = readImage(im2);

hSections   = floor(size(im1, 2)/spacing);
vSections   = floor(size(im1, 1)/spacing);
    
% Image derivatives
Gd          = gaussianDer(sigma);
    
It          = im2 - im1;
Ix          = conv2(im1, Gd, 'same');
Iy          = conv2(im1, Gd', 'same');
% [Ix, Iy]    = imgradientxy(im1);

% Flow vectors inialization in matrix
F           = zeros(vSections, hSections, 2);

% Indices of midpoints
ind                         = zeros(vSections, hSections, 2);
X                           = (0:hSections-1)*spacing+(spacing/2);
Y                           = (0:hSections-1)*spacing+(spacing/2);
[ind(:,:,1), ind(:,:,2)]    = meshgrid(X, Y);
       
% Determine optical flow per section of the image
for y = 0:vSections-1
    for x = 0:hSections-1            
        IxWindow    = Ix((spacing*y+1):(spacing*(y+1)), (spacing*x+1):(spacing*(x+1))); 
        IyWindow    = Iy((spacing*y+1):(spacing*(y+1)), (spacing*x+1):(spacing*(x+1)));
        ItWindow    = It((spacing*y+1):(spacing*(y+1)), (spacing*x+1):(spacing*(x+1)));
        
        A           = [IxWindow(:) IyWindow(:)];
        b           = ItWindow(:);        
        v           = pinv(A'*A)*(A')*b;
            
        F(y+1, x+1, 1)  = v(1);
        F(y+1, x+1, 2)  = v(2);
    end 
end

if plot == 1
% Show quiver plot
    fig1 = figure('Name', 'Flow on image 1');
    imshow(im1)
    hold on
    quiver(ind(:,:,1), ind(:,:,2), F(:,:,1), F(:,:,2))
        
    fig2 = figure('Name', 'Flow on image 2');
    imshow(im2)
    hold on
    quiver(ind(:,:,1), ind(:,:,2), F(:,:,1), F(:,:,2))
end

end