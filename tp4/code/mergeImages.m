function [ outIm ] = mergeImages(im1, im2, xOffset, yOffset)
%MERGEIMAGES combines im1 and im2, placing im2 at the location given by
%xLoc and yLoc on im1, (1,1) being the exact top left of im1
%  xDiff and yDiff are the number of pixels added to the left/top of im1

xDiff = max(1-xOffset, 0);
yDiff = max(1-yOffset, 0);

xStart2=xOffset+xDiff;
xEnd2=xOffset+xDiff+size(im2,2)-1;
yStart2=yOffset+yDiff;
yEnd2=yOffset+yDiff+size(im2,1)-1;

newW=max([xDiff+size(im1,2), xOffset+size(im2,2), size(im1,2), size(im2,2)]);
newH=max([yDiff+size(im1,1), yOffset+size(im2,1), size(im1,1), size(im2,1)]);

outIm=zeros(newH,newW,3);
outIm2=zeros(newH,newW,3);

imMask=zeros(newH,newW);
imMask(1+yDiff:yDiff+size(im1,1), 1+xDiff:xDiff+size(im1,2))=1;
im2Mask=im2(:,:,1);
im2Mask=(0*im2Mask)+(.5*ones(size(im2Mask)));
im2Mask(isnan(im2Mask)) = 1;

imMask(yStart2:yEnd2,xStart2:xEnd2)=imMask(yStart2:yEnd2,xStart2:xEnd2).*im2Mask;

outIm(1+yDiff:yDiff+size(im1,1), 1+xDiff:xDiff+size(im1,2),:)=im1;

for i=1:3
    outIm(:,:,i)=outIm(:,:,i).*imMask;
end
outIm2(yStart2:yEnd2,xStart2:xEnd2,:)=im2;

for i=1:3
    outIm2(:,:,i)=outIm2(:,:,i).*(ones(newH,newW)-imMask);
end

outIm=outIm+outIm2;
end

