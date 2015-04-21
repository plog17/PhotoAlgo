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


%% Calculate stroke
strokeLength=20;
cx=122;
cy=122;

x1=cx;
y1=cy;

lastSample=bilinearSampleImageAt(imE,x1,y1);
[dirx diry]=getDirXDirY(45);

tempx=x1+dirx;
tempy=y1+diry;

if pdist([x1,y1;tempx,tempy],'euclidean') > strokeLength
    %stop
else
    newSample=bilinearSampleImageAt(imE,tempx,tempy);

    if newSample<lastSample
        %stop
    else
                
    end
end





%% Final
imshow(final);
imwrite(final,'final.jpg');