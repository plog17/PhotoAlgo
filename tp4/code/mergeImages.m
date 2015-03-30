function [ outIm1 ] = mergeImages(im1, im2, xOffset, yOffset)
xGap = max(1-xOffset, 0);
yGap = max(1-yOffset, 0);

xBegin=xOffset+xGap;
xEnd=xOffset+xGap+size(im2,2)-1;
yBegin=yOffset+yGap;
yEnd=yOffset+yGap+size(im2,1)-1;

newWidth=max([xGap+size(im1,2), xOffset+size(im2,2), size(im1,2), size(im2,2)]);
newHeight=max([yGap+size(im1,1), yOffset+size(im2,1), size(im1,1), size(im2,1)]);

outIm1=zeros(newHeight,newWidth,3);
outIm2=zeros(newHeight,newWidth,3);

im1Mask=ones(newHeight,newWidth);
im2Mask=ones(newHeight,newWidth);
im1Mask(size(im1,1):size(im1,1)+yOffset,:)=0;
im1Mask(size(im1,2):size(im1,2)+xOffset,:)=0;

im2Mask(1:yOffset,:)=0;
im2Mask(:,1:xOffset)=0;
im2Mask(isnan(im2Mask))=0;

% moitié de la valeur du pixel pour mélanger
im2Mask=(.5*ones(size(im2Mask)));

im1Mask(yBegin:yEnd,xBegin:xEnd)=im1Mask(yBegin:yEnd,xBegin:xEnd).*im2Mask;
im2Mask=(ones(newHeight,newWidth)-im1Mask);

outIm1(1+yGap:yGap+size(im1,1), 1+xGap:xGap+size(im1,2),:)=im1;
outIm2(yBegin:yEnd,xBegin:xEnd,:)=im2;

for i=1:3
    outIm1(:,:,i)=outIm1(:,:,i).*im1Mask;
    outIm2(:,:,i)=outIm2(:,:,i).*im2Mask;
end

outIm1=outIm1+outIm2;

end

