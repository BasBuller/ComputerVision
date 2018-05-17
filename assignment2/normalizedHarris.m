%%normalize harris function
function [Ls,s,r,c] = normalizedHarris(img)




%% loop over different sigma values and store r and c

sizeIm = size(img);
Ls = zeros(sizeIm(1),sizeIm(2),13);
finalImage = zeros(size(img));

sigmarange = 1.2.^(0:12);
for i = 1:1:13
    li = zeros(sizeIm);
    sigma = sigmarange(i);
    [r,c] = harris(img,sigma) ;
    size(r);
    Laplacian = imfilter(img, fspecial('log',[3 3],sigma),'replicate','same') .* (sigma^2);
    li(sub2ind(sizeIm,r,c)) = abs(Laplacian(sub2ind(sizeIm,r,c)));
    Ls(:,:,i)=li;

    
%     sigma
%     size(r)
%     Laplacian = imfilter(img, fspecial('log',[3 3],sigma),'replicate','same') .* (sigma^2);
%     localImage(r,c) = abs(Laplacian(r,c));
%     localImage2 = ((imdilate(localImage, strel('square', 3))));
%     finalImage = max(finalImage,localImage2);
%     [r,c] = find(finalImage==localImage);
%     s(r,c)=sigma;
end

for i = 1:1:13
    finalImage = max(Ls(:,:,i),finalImage);
    
% figure('Name','Landscape Scale invariant')
% imshow(img)
% hold on
%imshow(s,[])
end

finalBlock = imdilate(finalImage,strel('square',3));
finalClean = (finalBlock == finalImage)& (finalImage>0);

s = zeros(size(img));
for i = 1:1:13
    sigma = sigmarange(i);
    s(finalBlock==Ls(:,:,i)&(Ls(:,:,i)~=0))=sigma;
end

showimg = img;
showimg(finalClean==1)=1;
% figure()
% imshow(showimg)
[r,c] = find(finalClean);



end
