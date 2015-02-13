function [image] = shiftPixelRight(image,rowIndex,columnIndex,logging)
if logging
fprintf('\nTrying rowIndex: %d, columnIndex: %d',rowIndex,columnIndex);
end
out=image;

channels=size(image,3);

RGB={channels};
lines={channels};
  
for i=1:channels
  RGB{i}=image(:,:,i);
end

for i=1:channels
  lines{i} = RGB{i}(rowIndex,:);
  left = lines{i}(:,1:columnIndex-1);
  right = lines{i}(:,columnIndex+1:end);
  lines{i}=cat(2,0,left,right);
end

if channels==3
    allLines=cat(3,lines{1},lines{2},lines{3});
    out(rowIndex,:,1)=allLines(:,:,1);
    out(rowIndex,:,2)=allLines(:,:,2);
    out(rowIndex,:,3)=allLines(:,:,3);
else
    allLines=cat(2,lines{1});
    out(rowIndex,:,1)=allLines(:,:,1);
end

image=out;

end
