save = false;
pathToTxt = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.txt';
pathToImage = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.png';

image = imread(pathToImage);
[ X,Y ] = readTxtFile(pathToTxt);


% Déclarer des valeurs symboliques
syms tx ty theta sx sy

% matrice de translation
A1 = [1 0 tx; 0 1 ty; 0 0 1];

%%Compute triangulation with Delaunay
tri = delaunay(X,Y);

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