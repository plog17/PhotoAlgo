path='../web/images/orig/paysage.jpeg';
im=getImageFromPath(path);
im=imresize(im,.25);
angle=45;
imshow(im);


%% Get intensity image
imG=rgb2gray(im);

%% Filter
fs=6;
filter=[fs fs];
G = fspecial('gaussian',filter,2);
imF = imfilter(imG,G,'same');
imshow(imF);

%% Sobel Filter
imE = edge(imF,'sobel');
imshow(imE);


%% Calculate stroke

strokeLength=20;
out=im;

cx=strokeLength;
cy=strokeLength;
while cx<(width-2*strokeLength)
   while cy<(height-2*strokeLength)
        fprintf('\n\n\nPrinting cx=%d cy=%d',cx,cy);
        % with stroke clipping
        [ x1, y1, x2, y2 ] = strokeClipping( strokeLength, imE, cx, cy, angle );
        out = drawStroke( im,out,x1,y1,x2,y2,angle,cx,cy );
        cy=cy+strokeLength;
   end  
   cx=cx+strokeLength;  
end

imshow(out);




%% Final
imshow(final);
imwrite(final,'final.jpg');