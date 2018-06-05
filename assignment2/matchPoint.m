
%% read images and convert to proper format

function [x1,y1,x2,y2] = matchPoint(im1,im2) 

im1 = 'landscape-a.jpg';
im2 = 'landscape-b.jpg';
adisplay = imread(im1);
bdisplay = imread(im2);
imga = im2double(rgb2gray(imread(im1)));
imgb = im2double(rgb2gray(imread(im2)));
imgas = single(rgb2gray(imread(im1)));
imgbs = single(rgb2gray(imread(im2)));


%% apply harris function on both images
[Lsa,sa,ra,ca] = normalizedHarris(imga);
sLista = sa(sub2ind(size(imga),ra,ca));


[Lsb,sb,rb,cb] = normalizedHarris(imgb);
sListb = sb(sub2ind(size(imgb),rb,cb));

%% describe features using sift
% run('../../vlfeat-0.9.21-bin/vlfeat-0.9.21/toolbox/vl_setup');
[fa,da] = vl_sift(imgas,'frames',[[ca'];[ra'];[2.*sLista+1]';[zeros(size(sLista))]'],'orientations');
[fb,db] = vl_sift(imgbs,'frames',[[cb'];[rb'];[2.*sListb+1]';[zeros(size(sListb))]'],'orientations');

%% match using vlsift
%[match, scores] = vl_ubcmatch(da,db);

%% match features using euclidian distance with 0.8 nearest neighbour
da = double(da);
db = double(db);

da2 = (sum(da.^2,1) .* ones(size(db,2),size(da,2)))';
db2 = sum(db.^2,1) .* ones(size(da,2),size(db,2));
dab = da'*db;

dist = sqrt(da2 + db2 - 2 .* dab);
[distk,distc] = mink(dist,2,2);
distsave = distc;
[forget distc] = min(dist,[],2);
distR = distk(:,1)./distk(:,2);

distR(distR>0.8)=0;
aList = find(distR);
bList = distc(distR >0);

%% Plot images with feature points
% figure('name','A')
% imshow(adisplay)
% hold on
% scatter(fa(1,(match(1,:))),fa(2,(match(1,:))),'r')
% scatter(ca,ra,'b')
% 
% figure('name','B')
% imshow(bdisplay)
% hold on
% scatter(fb(1,(match(2,:))),fb(2,(match(2,:))),'r')
% scatter(cb,rb,'b')
% size(match)
x1 = fa(1,(aList));
y1 = fa(2,(aList));

x2 = fb(1,(bList));
y2 = fb(2,(bList));



%% plot images with matches
figure('name','A and B with own algorithm')
imshow([adisplay bdisplay])
hold on

scatter(x1,y1,'r')
scatter(size(imgas,2)+x2,y2,'r')
line([x1;size(imgas,2)+x2],[y1;y2],'color','b')
% figure('name','A and B with vl_sift')
% imshow([adisplay bdisplay])
% hold on
% 
% scatter(fa(1,(match(1,:))),fa(2,(match(1,:))),'r')
% scatter(size(imgas,2)+fb(1,(match(2,:))),fb(2,(match(2,:))),'r')
% line([fa(1,match(1,:));size(imgas,2)+fb(1,match(2,:))],[fa(2,match(1,:));fb(2,match(2,:))],'color','b')

end
