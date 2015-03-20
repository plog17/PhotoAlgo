function [pts1,pts2] = matchPicturesPoints(image1path,image2path,fileToSave,nbPairs)
    im1 = im2double(imread(image1path));
    im2 = im2double(imread(image2path));

    subplot(1,2,1), image(im1), axis on, title(strcat('Image 1 '));
    subplot(1,2,2), image(im2), axis on, title(strcat('Image 2'));

    pts=ginput(nbPairs*2);
    
    pts1{nbPairs}=[];
    pts2{nbPairs}=[];
    
    for i=1:2*nbPairs
        if mod(i,2)==0
           pts2{i/2}=pts(i,:);
        else
           pts1{ceil(i/2)}=pts(i,:);
        end
    end
    
end