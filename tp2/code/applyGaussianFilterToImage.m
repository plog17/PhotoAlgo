function [ output ] = applyGaussianFilterToImage( image )
    filter=fspecial('gaussian',[5 5],2);
    output=imfilter(image,filter,'same');
end

