% Structure from Motion script
% Based on optical flow points from first part of assignment 4 for Computer
% Vision. 
%
% INPUT: 
% - pts: dataset containing all centered points that are tracked, shape
%        [m, n], m = number of views, n = number of points per view.
%
% OUTPUT:
% - 3D Graph of the tracked points
%
% Date: 29-04-2018
% Authors: Bas Buller & Rick Feith

function S = SfM(pts)
% Determine SVD composition and reduce to rank 3
[U, W, V]   = svd(pts);
U3          = U(:, 1:3);
W3          = W(1:3, 1:3);
V           = V';
V3          = V(1:3, :);
    
M           = U3 * sqrt(W3);
S           = sqrt(W3) *  V3;

save('M', 'M');

% resolve affine ambiguity
A           = M(1:2, :);
L0          = pinv(A'*A);

% Solve for L
L           = lsqnonlin(@myfun, L0);

% Recover C
C           = chol(L, 'lower');

% Update M and S
M           = M*C;
S           = pinv(C)*S;
end