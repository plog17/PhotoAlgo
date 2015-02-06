function [image] = shiftPixelRight(image,rowIndex,columnIndex)

  imgray = rgb2gray(image);
  line=[];

for i=1:3
  line = imgray(rowIndex,:);
  left = line(:,1:columnIndex-1);
  right = line(:,columnIndex+1:end);

  line=cat(2,0,left,right);


  image(rowIndex,:)=line;

end


  imGif(minEnergyOnLine(1,1),minEnergyOnLine(1,2),1)=255;
  imGif(minEnergyOnLine(1,1),minEnergyOnLine(1,2),2)=0;
  imGif(minEnergyOnLine(1,1),minEnergyOnLine(1,2),3)=0;

end
