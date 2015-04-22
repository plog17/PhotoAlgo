path='../web/images/orig/paysage.jpeg';
path2='../web/images/orig/beach.jpg';
im=getImageFromPath(path2);
im=imresize(im,1);

im=im(1:200,150:400,:);

angle=45;
strokeLength=7;
strokeWidth=3;

%% Get intensity image
imG=rgb2gray(im);

%% Filter
fs=2;
filter=[fs fs];
G = fspecial('gaussian',filter,1);
imF = imfilter(imG,G,'same');

% Sobel Filter
imE = edge(imF,'sobel');



%% Calculate stroke

out=paint(im,imE,angle,strokeLength,strokeWidth);


%%
subplot(1,2,1), imshow(im);
subplot(1,2,2), imshow(out);



%% Final
imshow(final);
imwrite(final,'final.jpg');