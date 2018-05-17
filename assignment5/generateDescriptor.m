function generateDescriptor()

command = './extract_features/extract_features.ln -haraff -i ./TeddyBearPNG/obj02_001.png -sift';
system(command);
command = './extract_features/extract_features.ln -haraff -i ./TeddyBearPNG/obj02_002.png -sift';
system(command);

end