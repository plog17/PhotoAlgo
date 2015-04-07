path='/Users/plauger/git/PhotoAlgo/tp5/web/images/origin/alignees/corridor/';




% Z(i,j) is the pixel values of pixel location number i in image j
% B(j) is the log delta t, or log shutter speed, for image j
% l is lamdba, the constant that determines the amount of smoothness
% w(z) is the weighting function value for pixel value z

% g(z) is the log exposure corresponding to pixel value z
% lE(i) is the log film irradiance at pixel location i


[g, lE] = gsolve(Z,B,l,w)