%% Assignment 6 Chaining LOADFILE
% Rick Feith

%% settings
run('../vlfeat-0.9.21/toolbox/vl_setup')

build = 0;  %build descriptors(1) or just read files(0)
%% read list of images from folder
folder = 'TeddyBearPNG';
folderList= dir(folder);
nameList = {folderList(:).name};

names = {};
for i = 1:length(nameList)
    if (endsWith(nameList{i},".png"))
        names = [names; nameList{i}];
    end
end


%% extract features and write properties to cells

teddys = cell(16,7);
for i = 1:length(names)
    [x1 y1 a1 b1 c1 desc1 x2 y2 a2 b2 c2 desc2] = extract_features(names{i},build);
    teddys{i,1} = names{i};
    teddys{i,2} = [x1; x2];
    teddys{i,3} = [y1; y2];
    teddys{i,4} = [a1; a2];
    teddys{i,5} = [b1; b2];
    teddys{i,6} = [c1; c2];
    teddys{i,7} = [desc1; desc2];  
    i
end

%% match features and write to cells
teddyMatch = cell(16, 4);
for i = 1:16
    if i~=16
        [matches] = vl_ubcmatch (teddys{i,7}' , teddys{i+1,7}');
        % |matched x1 | matched y1 | matched x2 | matched y2
        teddyMatch{i,1} = teddys{i,2}(matches(1,:));
        teddyMatch{i,2} = teddys{i,3}(matches(1,:));
        teddyMatch{i,3} = teddys{i+1,2}(matches(2,:));
        teddyMatch{i,4} = teddys{i+1,3}(matches(2,:));
    else
        [matches] = vl_ubcmatch (teddys{i,7}' , teddys{1,7}');
        teddyMatch{i,1} = teddys{i,2}(matches(1,:));
        teddyMatch{i,2} = teddys{i,3}(matches(1,:));
        teddyMatch{i,3} = teddys{1,2}(matches(2,:));
        teddyMatch{i,4} = teddys{1,3}(matches(2,:));
    end
    i
end

save descriptors teddys
save matches teddyMatch
