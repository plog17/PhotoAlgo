function [movedImage,xoffset,yoffset] = getAlignedImage(referenceImage, toBeAlignedImage)

minOffset=-20;
maxOffset=24;
bestSum=intmax;
xoffset=0;
yoffset=0;

referenceImage = referenceImage(400:800,400:800);
im2Shifted = toBeAlignedImage(400:800,400:800);

for x = minOffset:maxOffset
  for y = minOffset:maxOffset
  im2Shifted = circshift(im2Shifted,[x y]);
  newSum = sumImages(referenceImage,im2Shifted);

    if(newSum < bestSum)
      bestSum=newSum;
      xoffset=x;
      yoffset=y;
    end
  end
end

movedImage = circshift(toBeAlignedImage,[xoffset yoffset]);
