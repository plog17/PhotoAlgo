function pts = matchPicturesPoints(image1path,image2path,fileToSave,nbPairs)
    im1 = im2double(imread(image1path));
    im2 = im2double(imread(image2path));

    subplot(1,2,1), image(im1), axis on, title(strcat('Image 1 '));
    subplot(1,2,2), image(im2), axis on, title(strcat('Image 2'));

    pts=ginput(nbPairs*2);
end