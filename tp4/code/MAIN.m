image1path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/01.jpg';
image2path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/02.jpg';
image3path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/03.jpg';
image4path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/04.jpg';
image5path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/05.jpg';
nbPairs=5;

images{5}=[];
images{1}=getImageFromPath(image1path);
images{2}=getImageFromPath(image2path);
images{3}=getImageFromPath(image3path);
images{4}=getImageFromPath(image4path);
images{5}=getImageFromPath(image5path);


for i=1:5
    %[im1pts,im2pts] = matchPicturesPoints(images{i},images{i+1},nbPairs);
    pts=adaptiveNonMaximalSuppression(images{i});
    
    H = computeH(im1pts,im2pts);
    [warped,xOffset,yOffset] = warpImage(images{i+1},H);
    
    merge = mergeImages(images{i},warped,xOffset,yOffset);
    imshow(merge);
    
    imwrite(warped,strcat(i,'.jpg'));
end
