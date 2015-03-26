function [ outIm ] = mergeImages( im1, im2, xOffset, yOffset ) 
    mask2 = isnan(im2(:,:,1));
    dst = bwdist(mask2);
    
    out_img = zeros(size(im1));
end

