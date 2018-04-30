% Function to determine optical flow for a set of mutliple, chronological
% images for the Computer Vision course.
%
% input = list['image names']
% Matrix of points is of the following shape: 2M * N
%
% Authors: Bas Buller & Rick Feith

function [pointsx, pointsy] = optflowTracking(im, pts, sigma, plt)
% assign space to points
pointsx         = zeros(size(im, 3), size(pts, 2));
pointsy         = zeros(size(im, 3), size(pts, 2));
pointsx(1, :)   = pts(1, :);
pointsy(1, :)   = pts(2, :);

% assign weights to derivates
Ix              = zeros(size(im) - [0 0 1]);
Iy              = zeros(size(im) - [0 0 1]);
It              = zeros(size(im) - [0 0 1]);
    
% prepare Gaussian derivative
Gd              = gaussianDer(sigma);

% find x, y and t derivatives
for i = 1:size(im, 3)-1
    Ix(:,:,i)   = conv2(im(:,:,i), Gd, 'same');
    Iy(:,:,i)   = conv2(im(:,:,i), Gd', 'same');
    It(:,:,i)   = im(:,:,i+1) - im(:,:,i);
end

if plt == 1
    writerObj       = VideoWriter('test.avi');
    open(writerObj);
end

for i = 1:size(im, 3)-1             % Iterate through images
    for j = 1:size(pts, 2)          % Iterate through points  
        x               = uint16(round(pointsx(i, j)));
        y               = uint16(round(pointsy(i, j)));
        
        % Determine for patch around specified point
        ptch            = uint16(7);
        A1              = Ix((y-ptch):(y+ptch), (x-ptch):(x+ptch), i);
        A2              = Iy((y-ptch):(y+ptch), (x-ptch):(x+ptch), i);
        A               = [A1(:) A2(:)];
        b               = It((y-ptch):(y+ptch), (x-ptch):(x+ptch), i);
        b               = b(:);
        
        v               = pinv(A'*A)*(A')*b;
        pointsx(i+1, j)    = x + v(1);          % Something is going wrong in these lines, the flow points do not match well with the ground truth, they move in random directions it seems
        pointsy(i+1, j)    = y + v(2);
    end
    
    if plt == 1
        figure(1)
        imshow(im(:,:,i), [])
        hold on
        plot(pointsx(i, :), pointsy(i, :), '.g')    % Flow points
        plot(pts((2*i-1), :), pts((2*i), :), '.r')      % Ground truth points
        line([pointsx(i, :); pts((2*i-1), :)], [pointsy(i, :); pts((2*i), :)])
    
        frame = getframe;
        writeVideo(writerObj, frame);
    end    
end

if plt == 1
    close(writerObj);
end

end