% Generates the X and Y coordinates for a grid from which the optical flow
% vectors will be determined, an even spacing in both directions is used.

function [X, Y] = generateGrid(im, spacing)
    im          = readImage(im);
    height      = size(im, 1);  
    width       = size(im, 2);

    hSections   = floor(width/spacing);
    vSections   = floor(height/spacing);
    start       = ceil(spacing/2);
    
    x           = linspace(start, (spacing*(hSections-1)+start), hSections);
    y           = linspace(start, (spacing*(vSections-1)+start), vSections);
    [X, Y]      = meshgrid(x, y);
end