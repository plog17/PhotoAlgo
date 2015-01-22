function [movedImage,xoffset,yoffset] = searchAlignementAround(xoffset, yoffset,referenceImage, toBeAlignedImage)

%fprintf('\n---> New search around offset:(%d,%d)\n',xoffset,yoffset);

searchBound=3;

xMinOffset=xoffset-searchBound;
xMaxOffset=xoffset+searchBound;
yMinOffset=yoffset-searchBound;
yMaxOffset=yoffset+searchBound;
xoffset=0;
yoffset=0;

bestSum=intmax;
alignedImage=toBeAlignedImage;

for x = xMinOffset:xMaxOffset
  for y = yMinOffset:yMaxOffset
  alignedImage = circshift(toBeAlignedImage,[x y]);
  newSum = sumImages(referenceImage,alignedImage);
    if(newSum < bestSum)
      bestSum=newSum;
      xoffset=x;
      yoffset=y;
    end
  end
end

%fprintf('---> Best offset:(%d,%d)\n',xoffset,yoffset);
movedImage = circshift(toBeAlignedImage,[xoffset yoffset]);
