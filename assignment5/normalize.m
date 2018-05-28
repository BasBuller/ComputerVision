
%% function that normalizes input data for 8-point algorithm

function [x,y,T] = normalize(x,y)
mx = 1/max(size([x])) * sum([x]);
my = 1/max(size([y])) * sum([y]);
d = 1/max(size([x]))* sum(sqrt(([x]-mx).^2 + ([y]-my).^2));
T = [sqrt(2)/d 0 -mx*sqrt(2)/d; 0 sqrt(2)/d -my*sqrt(2)/d; 0 0 1];
p = T * [[x]'; [y]'; ones(size([x]'))];
x= p(1,:);
x = x(:);
y = p(2,:);
y = y(:);


end