function [average, average_dist] = check_normalize(x,y)
average = mean(x) + mean(y);

average_dist = sum(sqrt(x.^2 + y.^2))/size(x,1);


end