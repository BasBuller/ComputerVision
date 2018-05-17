function F = fundEstimation(descFile1, descFile2)
% Determines an estimate for the fundamental matrix of 2 images

run('/home/bas/Documents/MATLAB/vlfeat-0.9.21/toolbox/vl_setup');

% Load features into variables
[x1, y1, a1, b1, c1, desc1] =  loadFeatures(descFile1);
[x2, y2, a2, b2, c2, desc2] =  loadFeatures(descFile2);

% Determine matches between images
[matches, scores]           = vl_ubcmatch(desc1', desc2');
match1                      = matches(1, 1:20);
match2                      = matches(2, 1:20);

% Estimation of fundamental matrix
n   = 8;
A   = zeros(n, 9);                    % need 8 points as each pair gives only 1 constraint on F
F   = zeros(9, 1);
B   = zeros(n, 1);
for i = 1:n
    A(i, :)     = [x2(match2(i))*x1(match1(i)) x2(match2(i))*y1(match1(i)) x2(match2(i)) y2(match2(i))*x2(match2(i)) y2(match2(i))*y1(match1(i)) y2(match2(i)) x1(match1(i)) y1(match1(i)) 1];
end

[U, D, V]       = svd(A)
D(D==0)         = inf;
[m, loc]        = min(min(D));
F               = V(:, loc);
A