function [sumImage] = ccn(image1, image2)
vect1 = image1 / norm(image1);
vect2 = image2 / norm(image2);
ccn = dot(vect1,vect2);
