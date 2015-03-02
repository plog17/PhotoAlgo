function [ rowToDelete ] = getRowToDelete( image, percentage, vertical )
if vertical
    rowToDelete = floor(size(image,1)*percentage/100);
else
    rowToDelete = floor(size(image,2)*percentage/100);
end

end

