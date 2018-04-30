function im = readImage(inputImage)
    if size(imread(inputImage), 3) == 3
        im = im2double(rgb2gray(imread(inputImage)));
    else
        im = im2double(imread(inputImage));
    end
end