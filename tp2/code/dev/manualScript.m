im=imread('house_by_jim_mccann.jpg');
im=im2double(im);

imRotate=imrotate(im,90);

BW = roipoly(im)