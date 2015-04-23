clear;
path='../web/images/orig/paysage.jpeg';
path2='../web/images/orig/beach.jpg';
im=getImageFromPath(path2);
im=imresize(im,1);
angle=45;
strokeLength=10;
strokeWidth=3;

%%
% Get intensity image
imG=rgb2gray(im);

% Filter
fs=7;
filter=[fs fs];
G = fspecial('gaussian',filter,2);
imF = imfilter(imG,G,'same');

% Filtrer
imE = edge(imF,'canny');

%imE = edge(imF,'sobel');
%fonction energie tp2
%imE=calculateEnergy(imF);

%% Peinturons!
[height, width]=size(imE);
[meshxs, meshys]=meshgrid(1:width,1:height);

%[out,painted]=paint(im,imE,angle,strokeLength,strokeWidth,meshxs,meshys);
[out,painted]=paintRandom(im,imE,angle,strokeLength,strokeWidth,meshxs,meshys);

imshow(out); 

%%
subplot(1,2,1), imshow(im);
subplot(1,2,2), imshow(out);



%% Final
imshow(final);
imwrite(final,'final.jpg');