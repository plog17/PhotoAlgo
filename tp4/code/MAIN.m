image1path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/01.jpg';
image2path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/02.jpg';
image3path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/03.jpg';
image4path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/04.jpg';
image5path = '/Users/plauger/git/PhotoAlgo/tp4/web/images/origin/panorama1/05.jpg';
nbPairs=5;

images{5}=[];
merged{5}=[];
images{1}=getImageFromPath(image1path);
images{2}=getImageFromPath(image2path);
images{3}=getImageFromPath(image3path);
images{4}=getImageFromPath(image4path);
images{5}=getImageFromPath(image5path);


im1=images{1};
merge=im1;

for i=1:5
    [im1pts,im2pts] = matchPicturesPoints(im1,images{i+1},nbPairs);    
    H = computeH(im1pts,im2pts);
    [warped,xOffset,yOffset] = warpImage(images{i+1},H);
    merge = mergeImages(merge,warped,xOffset,yOffset);
    merged{i}=merge;
    imshow(merge);
    imwrite(warped,strcat(int2str(i),'_panoManual.jpg'));
end
imwrite(warped,'panoManual.jpg');