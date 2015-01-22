
urlImage1 = 'http://lcweb2.loc.gov/service/pnp/prok/00700/00778v.jpg';
urlImage2 = 'http://lcweb2.loc.gov/service/pnp/prok/00700/00716v.jpg';
urlImage3 = 'http://lcweb2.loc.gov/service/pnp/prok/01500/01565v.jpg';

im1 = imread(urlImage3);
im1 = im2double(im1);

xmin = 0;
ymin = 0;
width = 390;
height = 335;
gap = 0;

blue = [xmin ymin width height];
green = [xmin ymin+height+gap width height];
red = [xmin ymin+2*(height+gap) width height];

B = imcrop(im1, blue);
G = imcrop(im1, green);
R = imcrop(im1, red);

displayRGB(R,G,B);

movedG = getAlignedImage(B,G);
movedR = getAlignedImage(B,R);

RGB1 = cat(3,R,G,B);
RGB2 = cat(3,movedR,G,B);
RGB3 = cat(3,movedR,movedG,B);

imwrite(RGB1,'res2_1.jpg');
imwrite(RGB2,'res2_2.jpg');
imwrite(RGB3,'res2_3.jpg');

%test = sumImages(R, R);
%[x,y] = findBestDisplacement(R,G);

% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum", and "imresize" (for multiscale)

% create a color image (3D array)
% ... use the "cat" command

% show the resulting image
% ... use the "imshow" command
%figure;imshow(aRGB);

% save result image
%imwrite(aRGB,['result-' imname]);