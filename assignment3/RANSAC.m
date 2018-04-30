function [inliers, totalInliers, trans] = RANSAC(P, xa, ya, xb, yb, threshold)
%% 1. Initialize seed and parameters
%     s = RandStream('mt19937ar', 'Seed', 1);
%     RandStream.setGlobalStream(s);
%     perm = randperm(size(xa, 2));
%     seed = perm(1:P*N);

    inliers         = [];
    totalInliers    = 0;
    trans           = [];
    size(xa)
    floor(size(xa,2)/P)
    
%% 2. Loop to find optimal affine transformation
    for run = 1:floor(size(xa,2)/P)
        seed = randperm(size(xa, 2), P);
        
        A = zeros(2*P, 6);
        b = zeros(2*P, 1);
        for i = 1:1:P
            x1 = xa(seed(i));
            y1 = ya(seed(i));
            x2 = xb(seed(i));
            y2 = yb(seed(i));

            A((i*2-1), :)   = [x1 y1 0 0 1 0];
            A((2*i), :)     = [0 0 x1 y1 0 1];

            b(2*i -1)       = x2;
            b(2*i)          = y2;
        end
        
        x       = pinv(A) * b;

        A       = [x(1) x(2); x(3) x(4)];
        b       = [x(5); x(6)];

        framesT = A * [xa; ya] + b;
        xt      = framesT(1, :);
        yt      = framesT(2, :);

        inl     = find(sqrt(sum([(xb-xt); (yb-yt)].^2)) < threshold);
        
        if length(inl) > totalInliers
            totalInliers    = length(inl)
            inliers         = inl;
        end    
    end
    
    Atrans  = zeros(2*totalInliers, 6);
    btrans  = zeros(2*totalInliers, 1);
    for i = 1:1:totalInliers
        Atrans((2*i-1), :)  = [xa(inliers(i))   ya(inliers(i))  0               0               1 0];
        Atrans((2*i), :)    = [0                0               xa(inliers(i))  ya(inliers(i))  0 1];
        
        btrans(2*i - 1)     = xb(inliers(i));
        btrans(2*i)         = yb(inliers(i));
    end
    
    trans = pinv(Atrans) * btrans;

end