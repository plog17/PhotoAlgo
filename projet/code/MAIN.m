path='../web/images/orig/paysage.jpeg';
im=getImageFromPath(path);
im=imresize(im,.1);
angle=45;
imshow(im);


%% Get intensity image
imG=rgb2gray(im);

%% Filter
fs=4;
filter=[fs fs];
G = fspecial('gaussian',filter,2);
imF = imfilter(imG,G,'same');
imshow(imF);

%% Sobel Filter
imE = edge(imF,'sobel');
imshow(imE);


%% Calculate stroke

out=paint(im,imE,angle);

imshow(out);




%% Final
imshow(final);
imwrite(final,'final.jpg');