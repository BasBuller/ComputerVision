%% finding fundamental matrix

function [F,Ff] = fundamentalMatrix(x1,y1,x2,y2,match1,match2)
N = 8;
A  = zeros(N,9);
for i = 1:N
    A(i,:) = [x2(match2(i))*x1(match1(i)) x2(match2(i))*y1(match1(i)) x2(match2(i)) y2(match2(i))*x1(match1(i)) y2(match2(i))*y1(match1(i)) y2(match2(i)) x1(match1(i)) y1(match1(i)) 1]; 
end
[U, D, V] = svd(A);
D(D==0)=inf;
[m,loc] = min(min(D));
F = V(:,loc);


F = reshape(F,[3,3]);
[Uf,Df,Vf] =svd(F);
Df(3,3) = 0;
Ff = Uf * Df * Vf';


end