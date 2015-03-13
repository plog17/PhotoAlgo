addpath('InPolygon-MEX/');

save = false;
pathToTxtFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.txt';
pathToImageFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.png';
pathToTxtSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.txt';
pathToImageSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.png';

image1 = imread(pathToImageFirst);
[ X,Y ] = readTxtFile(pathToTxtFirst);

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
tri = delaunay(X,Y);
figure(1);
triplot(tri,X,Y);

%find which triangle the pixel belongs to

%loop for every triangle in triangulation
for it=0:size(tri,1)
    
    
    
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