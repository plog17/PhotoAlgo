function [sumImage] = sumImages(image1, image2)
sumImage=sum((image1(:)-image2(:)).^2) ;
