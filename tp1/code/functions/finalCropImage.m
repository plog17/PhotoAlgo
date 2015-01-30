function cropedImage = finalCropImage(image)

[imHeight, imWidth] = size(image);

%fulldef
%crHeight = 90;
%crWidth = 35;

%sd
crHeight =15;
crWidth = 7;

xmin=crWidth;
ymin=crHeight;
width=imWidth-(crWidth);
height=imHeight-(crHeight);

cropDetails = [xmin ymin width height];

cropedImage = imcrop(image, cropDetails);
