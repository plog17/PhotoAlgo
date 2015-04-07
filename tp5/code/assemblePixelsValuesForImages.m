function [ Z ] = assemblePixelsValuesForImages( images_array, pixels,channel)
    Z=zeros(size(pixels,2),size(images_array,2));
    for i=1:size(images_array,2)
        for j=1:size(pixels,2)
            curImage=images_array{i};
            curPixel=pixels{j};
            Z(j,i)= curImage(curPixel(1,1),curPixel(1,2),channel);
        end
    end   
end

