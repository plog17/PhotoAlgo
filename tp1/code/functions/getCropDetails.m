function cropDetails = getCropDetails(imageSize)
[imHeight, imWidth] = size(imageSize);

cropedFactorHeight = 12;
cropedFactorWidth = 12;

crHeight = imHeight/cropedFactorHeight;
crWidth = imWidth/cropedFactorWidth;

xmin=crWidth;
ymin=crHeight;
width=imWidth-(2*crWidth);
height=imHeight-(2*crHeight);

cropDetails = [xmin ymin width height];
