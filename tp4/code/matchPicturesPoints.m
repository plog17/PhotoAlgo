function [im1_pts,im2_pts] = matchPicturesPoints(im1,im2,nbPairs)
    subplot(1,2,1), image(im1), axis on, title(strcat('Image 1 '));
    subplot(1,2,2), image(im2), axis on, title(strcat('Image 2'));

    pts=ginput(nbPairs*2);
    
    im1_pts=ones(nbPairs,2);
    im2_pts=ones(nbPairs,2);
    
    for i=1:2*nbPairs
        if mod(i,2)==0
           im2_pts(i/2,:)=pts(i,:);
        else
           im1_pts(ceil(i/2),:)=pts(i,:);
        end
    end
    
end