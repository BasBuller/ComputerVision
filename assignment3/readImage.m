function im = readImage(inputImage)
    if size(imread(inputImage), 3) == 3
        im = im2single(rgb2gray(imread(inputImage)));
    else
        im = im2single(imread(inputImage));
    end
end