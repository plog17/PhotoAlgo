function [movedImage,xoffset,yoffset] = getAlignedImage(referenceImage, toBeAlignedImage)

minOffset=-12;
maxOffset=12;
bestSum=intmax;
im2Shifted=toBeAlignedImage;
xoffset=0;
yoffset=0;

for x = minOffset:maxOffset
  for y = minOffset:maxOffset
  im2Shifted = circshift(toBeAlignedImage,[x y]);
  newSum = sumImages(referenceImage,im2Shifted);

    if(newSum < bestSum)
      bestSum=newSum;
      xoffset=x;
      yoffset=y;
    end
  end
end

movedImage = circshift(toBeAlignedImage,[xoffset yoffset]);
