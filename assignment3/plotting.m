function plotting(ima, imb, xa, ya, xb, yb)
    figure()
    imshow([ima imb], [])
    hold on
    scatter(xa, ya, 'r')
    scatter(size(ima,2)+xb, yb, 'r')
    line([xa; size(ima,2)+xb], [ya; yb])
end