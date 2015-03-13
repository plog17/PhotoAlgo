addpath('InPolygon-MEX/');

save = false;
pathToTxtFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.txt';
pathToImageFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.png';
pathToTxtSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.txt';
pathToImageSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.png';

image1 = imread(pathToImageFirst);
[ X1,Y1 ] = readTxtFile(pathToTxtFirst);
image2 = imread(pathToImageSecond);
[ X2,Y2 ] = readTxtFile(pathToTxtSecond);


% symbolics
syms tx ty theta sx sy

% matrice de translation
A1 = [1 0 tx; 0 1 ty; 0 0 1];

% matrice de rotation
A2 = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];

% matrice d'échelle
A3 = [sx 0 0; 0 sy 0; 0 0 1];

% essayons A1*A2*A3
T1 = A1*A2*A3;


%%Compute triangulation with Delaunay
tri = delaunay(X1,Y1);
figure(1);
triplot(tri,X1,Y1);




%loop for every triangle in triangulation
for it=1:size(tri,1)
    c1 = [X1(tri(it,1)),Y1(tri(it,1))];
    c2 = [X1(tri(it,2)),Y1(tri(it,2))];
    c3 = [X1(tri(it,3)),Y1(tri(it,3))];
    
    %define triangle region
    triX(1)=X1(tri(it,1));
    triX(2)=X1(tri(it,2));
    triX(3)=X1(tri(it,3));
    triY(1)=Y1(tri(it,1));
    triY(2)=Y1(tri(it,2));
    triY(3)=Y1(tri(it,3));
    
    %find which triangle the pixel belongs to
    [IN,ON,IN_strict] = InPolygon(px,py,cx,cy);
    
    
end


%Interpolate
%Vq = interp2(X,Y

%%Calculate de morphed image
%morphed_img = morph(img1, img2, img1_pts, img2_pts, tri, warp_frac, dissolve_frac);

if save
    vw = VideoWriter([filename '.mp4']); 
    vw.FrameRate = 30; % selection du nombre de trames par seconde du video 
    open(vw); 
    % calculs!

    writeVideo(vw,img); %pour chaque trame (img) 
    close(vw); %une fois toutes les images ajoutés au video
end