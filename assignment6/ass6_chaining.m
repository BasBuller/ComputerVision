%% assignment 6 chaining of inlier points using chaining.
% author: Bas Buller & Rick Feith

%% load data previously generated
clear all
load descriptors
load matches
% load inliers
inliers = 1:100;

%% create pointview matrix using matches between image 1 and 2
pointviewmatrix(1,:) = teddyMatch{1,1}(1,inliers);
pointviewmatrix(2,:) = teddyMatch{1,1}(2,inliers);
tic
%% add extra columns and rows by adding more images
for i = 2:16
    % find intersection between arrays. IA shows indices of already present
    % matches. IB gives the position of that point in the new matches that
    % need to be added.
    matches = teddyMatch{i,1}(:,inliers);
    [~, IA,IB] = intersect(pointviewmatrix(i,:),matches(1,:));
    % add next row with matches in next image corresponding to already
    % present points in last column
    pointviewmatrix(i+1,IA) = matches(2,IB);
    
    %remove already added matches
    matches(:,IB) = [];
    % add leftover matches to appropriate rows
    pointviewmatrix(i:(i+1),(end+1):(end+size(matches,2))) = matches;  
end


 orginal = pointviewmatrix;
 [~, IA,IB] = intersect(pointviewmatrix(1,:),pointviewmatrix(17,:));
 pointviewmatrix(:,IA(2:end)) = pointviewmatrix(:,IA(2:end)) + pointviewmatrix(:,IB(2:end));
pointviewmatrix(:,IB(2:end)) = [];
nonzero17 = find(pointviewmatrix(17,:));
nonzero1 = find(pointviewmatrix(1,:));
checking = ~ismember(nonzero17,nonzero1);
nonzero17 = nonzero17(checking);
tocopy = [pointviewmatrix(:,nonzero17)];
pointviewmatrix(:,nonzero17) = [];
pointviewmatrix = [tocopy pointviewmatrix];
pointviewmatrix(1,1:size(tocopy,2)) = pointviewmatrix(17,1:size(tocopy,2));
pointviewmatrix = pointviewmatrix(1:16,:); 
 toc