path='../web/images/orig/paysage.jpeg';
im=getImageFromPath(path);
imshow(im);


%% Get intensity image
imG=rgb2gray(im);

%% Filter
fs=15;
filter=[fs fs];
G = fspecial('gaussian',filter,2);
imF = imfilter(imG,G,'same');
imshow(imF);

%% Sobel Filter
imE = edge(imF,'sobel');
imshow(imE);






%% Final
imshow(final);
imwrite(final,'final.jpg');