function cropedImage = finalCropImage(image)

[imHeight, imWidth] = size(image);

%fulldef
%crHeight = 72;
%crWidth = 20;

xmin=crWidth;
ymin=crHeight;
width=imWidth-(crWidth);
height=imHeight-(crHeight);

cropDetails = [xmin ymin width height];

cropedImage = imcrop(image, cropDetails);
