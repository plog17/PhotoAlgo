function [ imwarped ] = warpImage( im,H )
    [height width channels]=size(im);
    
    %corners
    topLeft=[1 1 1]/H;
    topRight=[width 1 1]/H;
    bottomLeft=[1 height 1]/H;
    bottomRight=[width height 1]/H;
    minX=floor(min([topLeft(1) topRight(1) bottomLeft(1) bottomRight(1)]));
    minY=floor(min([topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]));
    maxX=ceil(max([topLeft(1) topRight(1) bottomLeft(1) bottomRight(1)]));
    maxY=ceil(max([topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]));
    
    
    
%im = rgb2gray(im);

% size of the image
szIm = size(im);
size2=szIm(1,1:2);
% default gray value
grayDefault = 127;




% pixel coordinates in original image
[x,y] = meshgrid(1:size(im,2),1:size(im,1));

% pixel coordinates in result image
pix   = [x(:)'; y(:)'];

%if any(szIm ~= size(im))
%[xp,yp] = meshgrid(1:szIm(2),1:szIm(1));
%pix   = [xp(:)'; yp(:)'];
%else
%pix   = [x(:)'; y(:)'];
%end


% homogeneous pixels in result frame.
filler=ones(2,prod(szIm));
hPixels = [ pix; filler];

% corresponding warped points in original frame
hScene  = H*hPixels;

% pixel coords in original frame.
xprime=(hScene(1,:)./(hScene(3,:)))';
yprime=(hScene(2,:)./(hScene(3,:)))';
xprime = reshape(xprime, szIm);
yprime = reshape(yprime, szIm);

% truc de pro: vectoriser l'image en un vecteur de Nx3 (N = # de pixels)
imgVec = reshape(im, size(im,1)*size(im,2), size(im,3));

% Warping an image according to the homography
result = interp2(x,y,imgVec,xprime,yprime);%,'linear',grayDefault); %, '*linear'
result(isnan(result)) = grayDefault;
result = reshape(result,size2);

% re-convertissons en format "image"
imgWb = reshape(imgVec, size(im,1), size(im,2), size(im,3));


end

