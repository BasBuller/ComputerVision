function [c1,c2,c3,c4] = stitching(im1, im2, T, plot, floors,color)    
    % Function to stitch two alligned images together.
    % Note that the transformation image transforms the initial image such that
    % its keypoints match that on the second image. 
    % Counting starts at the top left of the matrix/image!
    
    
        %% read images 
    if color == 1
        im1 = im2single(imread(im1));
        im2 = im2single(imread(im2));
    else
        im1 = readImage(im1);
        im2 = readImage(im2);
    end
    
    %% calculate location of cornerpoints
    
    A       = T(1:2, 1:2);
    b       = T(1:2, 3);
    
    c1 = A*[0; 0] + b;
    c2 = A*[size(im2,2); 0] + b;
    c3 = A*[0; size(im2,1)] + b;
    c4 = A*[size(im2,2);size(im2,1)] + b;
    
    %c2-c1,c3-c1,c4-c2,c4-c3

    
    %% transform images
    tform  = maketform('affine', T');
    im2_t  = imtransform(im2, tform, 'bicubic');
    
%% calculate width and height of total panorama

    width = ceil(max([c1(1),c2(1),c3(1),c4(1)]));
    height = ceil(max([c1(2),c2(2),c3(2),c4(2),size(im1,1)]));
    vOffset = min([c1(2),c2(2),c3(2),c4(2)]);
    hOffset = min([c1(1),c2(1),c3(1),c4(1)]);
    if floors == 1
        hOffset = floor(hOffset);
        vOffset = floor(vOffset);
    else
        hOffset = round(hOffset);
        vOffset = round(vOffset);
    end
    
    if color == 1
        final                                                                           = zeros(height, width,3);
        final((vOffset+1):(vOffset+size(im2_t,1)), (hOffset+1):(hOffset+size(im2_t,2)),:)   = im2_t;
        final(1:size(im1, 1), 1:size(im1, 2),:)                                           = im1;
    else
        final                                                                           = zeros(height, width);
        final((vOffset+1):(vOffset+size(im2_t,1)), (hOffset+1):(hOffset+size(im2_t,2)))   = im2_t;
        final(1:size(im1, 1), 1:size(im1, 2))                                           = im1;
    end
    
    
    if plot == 1
        figure()
        imshow(final);
        saveas(gcf, 'stitched.png');
    end
    save stitch.mat
end