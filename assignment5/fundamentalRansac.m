function [Ff,test] = fundamentalRansac(x1,y1,x2,y2,N,threshold)

%% 1. Initialize seed and parameters
    P = 8;
    s = RandStream('mt19937ar', 'Seed', 1);
    RandStream.setGlobalStream(s);
    perm = randperm(size(x1, 1), P);
%     seed = perm(1:P*N);




    inliers         = [];
    totalInliers    = 0;
    Fundamental          = [];
    
%% 2. Loop to find optimal Fundamental Matrix
    for run = 1:N
        seed = randperm(size(x1, 1), P);
        
       
        A  = zeros(P,9);
        for i = 1:P
            A(i,:) = [x2(i)*x1(i) x2(i)*y1(i) x2(i) y2(i)*x1(i) y2(i)*y1(i) y2(i) x1(i) y1(i) 1]; 
        end
        [U, D, V] = svd(A);
        D(D==0)=inf;
        [m,loc] = min(min(D));
        F = V(:,loc);


        F = reshape(F,[3,3]);
        [Uf,Df,Vf] =svd(F);
        Df(3,3) = 0;
        
        F = Uf * Df * Vf';
        
        
        p1 = [x1';y1';ones(1,length(x1))];
        p2 = [x2';y2';ones(1,length(x2))];
%         size(p1)
%         size(p2)
%         size(F)
        Fp1 = F*p1;
        FTp1 = F'*p1;
        
        num = diag((p2'*F*p1)).^2;
        den = (Fp1(1,:)).^2 + (Fp1(2,:)).^2 + (FTp1(1,:)).^2 + (FTp1(2,:)).^2;

        inl     = find( num'./den < threshold);
        
        if length(inl) > totalInliers
            totalInliers    = length(inl);
            inliers         = inl;
        end    
    end
    save debug
    size(x2)
    size(x1)
    totalInliers
    max(inliers)
    A  = zeros(totalInliers,9);
    for i = 1:totalInliers
        A(i,:) = [x2(inliers(i))*x1(inliers(i)) x2(inliers(i))*y1(inliers(i)) x2(inliers(i)) y2(inliers(i))*x1(inliers(i)) y2(inliers(i))*y1(inliers(i)) y2(inliers(i)) x1(inliers(i)) y1(inliers(i)) 1]; 
    end
    [U, D, V] = svd(A);
    D(D==0)=inf;
    [m,loc] = min(min(D));
    F = V(:,loc);


    F = reshape(F,[3,3]);
    [Uf,Df,Vf] =svd(F);
    Df(3,3) = 0;
    
    Ff = Uf * Df * Vf';

    test = inliers(1);
end