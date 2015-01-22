function [sumImage] = sumImage(image1, image2)
sumImage=sum((image1(:)-image2(:)).^2) ;
