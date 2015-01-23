function [movedImage,xoffset,yoffset] = getAlignedImage(referenceImage, toBeAlignedImage)

minOffset=-15;
maxOffset=15;
bestSum=intmax;
xoffset=0;
yoffset=0;

%referenceImage = referenceImage(500:700,500:700);
%toBeAlignedImage = toBeAlignedImage(500:700,500:700);

im2Shifted=toBeAlignedImage;

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
