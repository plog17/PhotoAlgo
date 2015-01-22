function [alignedImage,xoffset,yoffset] = getAlignedImageMultipleScales(referenceImage, toBeAlignedImage, pyramidHeight)
alignedImage=toBeAlignedImage;
xoffset=0;
yoffset=0;

while(pyramidHeight>=0)
  resizeFactor=1/(2^pyramidHeight);
  referenceResized = imresize(referenceImage,resizeFactor);
  toBeAlignedResized = imresize(toBeAlignedImage,resizeFactor);

  [alignedImage,xoffset,yoffset] = searchAlignementAround(2*xoffset,2*yoffset,referenceResized,toBeAlignedResized);
  pyramidHeight=pyramidHeight-1;
end

fprintf('Offset of full definition image is:(%d,%d)\n',xoffset,yoffset);
