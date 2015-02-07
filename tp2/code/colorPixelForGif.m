function [ imageWithColoredPixel ] = colorPixelForGif( imageToColor,minEnergyPixelRow,minEnergypixelColumn)
    imageToColor(minEnergyPixelRow,minEnergypixelColumn,1)=255;
    imageToColor(minEnergyPixelRow,minEnergypixelColumn,2)=0;
    imageToColor(minEnergyPixelRow,minEnergypixelColumn,3)=0;
    imageWithColoredPixel=imageToColor;
end

