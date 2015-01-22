
fprintf('-------Reading picture file-------\n');
filename='00106v.jpg';
%filename = '00128u.tif';

im1 = imread(filename);
im1 = im2double(im1);
B = im1(1:height,:);
G = im1(height+1:height*2,:);
R = im1(height*2+1:height*3,:);

B = cropImage(B);
imshow(B);

G = cropImage(G);
imshow(G);

R = cropImage(R);
imshow(R);
