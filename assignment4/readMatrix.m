function [M, MC] = readMatrix()
    M           = textread('model_house/measurement_matrix.txt');
    
    numPts      = size(M, 2);
    MC          = M - repmat(sum(M,2) / numPts, 1, numPts);
end