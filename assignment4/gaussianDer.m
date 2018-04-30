%% Function Question 4
function Gd = gaussianDer(sigma)
    x   = -3*sigma:3*sigma;
    B = 1.*(exp((-x.^2)./(2.*sigma.^2)))./(sigma.*sqrt(2.*pi));
    G = B./sum(B);
    Gd  = -x.*G./(sigma^2);
end