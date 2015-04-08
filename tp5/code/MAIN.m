path='/Users/plauger/git/PhotoAlgo/tp5/web/images/origin/alignees/corridor/';
numPixels=250;
l=1;
row=25;
col=45;
channel=3;
reducedFactor=1/10;


% Z(i,j) is the pixel values of pixel location number i in image j
% B(j) is the log delta t, or log shutter speed, for image j
% l is lamdba, the constant that determines the amount of smoothness
% w(z) is the weighting function value for pixel value z

% g(z) is the log exposure corresponding to pixel value z
% lE(i) is the log film irradiance at pixel location i


fprintf('\n---Chargement images et vitesses d''obturation\n');
[images_array,B]=getImageFromPath(path);

fprintf('---Sélection pixels au hasard\n');
pixels=getPixels(images_array{1},numPixels);
Z=assemblePixelsValuesForImages(images_array,pixels,1);


fprintf('---gsolve\n');
w = ponderationFunction(Z);

for channel = 1:3
    rsimages = reshape(simages(:,:,channel,:), srow*scol, number);
    [g(:,channel), lnE(:,channel)] = gsolve(Z, B, l, w);
end