function [image] = shiftPixelRight(image,rowIndex,columnIndex)

  RGB={3};
  RGB{1}=image(:,:,1);
  RGB{2}=image(:,:,2);
  RGB{3}=image(:,:,3);

  lines={3};

for i=1:3
  lines{i} = RGB{i}(rowIndex,:);
  left = lines{i}(:,1:columnIndex-1);
  right = lines{i}(:,columnIndex+1:end);
  lines{i}=cat(2,0,left,right);
end

  allLines=cat(3,lines{1},lines{2},lines{3})
  image(rowIndex,:,1)=allLines(:,:,1);
  image(rowIndex,:,2)=allLines(:,:,2);
  image(rowIndex,:,3)=allLines(:,:,3);

  image=image(2:end,:,:);

end
