%% Function Question 4
function Gd = gaussianDer(sigma)
    x   = -3*sigma:3*sigma;
    Gd  = -x.*gaussian(sigma)./(sigma^2);
end