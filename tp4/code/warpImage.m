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
    

% size of the image
szIm = size(im);

% default gray value
grayDefault = 127;


% pixel coordinates in original image
[x,y] = meshgrid(1:size(im,2),1:size(im,1));

% pixel coordinates in result image
if any(szIm ~= size(im))
[xp,yp] = meshgrid(1:szIm(2),1:szIm(1));
pix   = [xp(:)'; yp(:)'];
else
pix   = [x(:)'; y(:)'];
end

% homogeneous pixels in result frame.
t=ones(1,prod(szIm));
hPixels = [ pix'; t];

% corresponding warped points in original frame
hScene  = H*hPixels;

% pixel coords in original frame.
xprime=(hScene(1,:)./(hScene(3,:)))';
yprime=(hScene(2,:)./(hScene(3,:)))';
xprime = reshape(xprime, szIm);
yprime = reshape(yprime, szIm);

% Warping an image according to the homography
result = interp2(x,y,im,xprime,yprime, '*linear');
result(isnan(result)) = grayDefault;
result = reshape(result,szIm);
    
end

