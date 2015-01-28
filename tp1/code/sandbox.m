
fprintf('-------Reading picture file-------\n');
filename='/Users/plauger/Pictures/Photographie Algorithmique/TP1/images/01043u.tif';
%filename = '00128u.tif';

im1 = imread(filename);
im1 = im2double(im1);

%im1 = rgb2gray(im1);

%B = im1(1:height,:);
%G = im1(height+1:height*2,:);
%R = im1(height*2+1:height*3,:);
%height = size(im1,1);

%im1=im1(20:height,:);

%im1 = cat(3, im1, im1, im1);

imshow(im1);

