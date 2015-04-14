path='../web/images/origin/sphere/';
path3='../web/images/perso3/sphere/';


addpath('tests/program/')
addpath('radiance/')


%% Carte de radiance
im=GenerateHDR(path3,'perso3');
imshow(im);

im2=GenerateHDR(path,'origin');
imshow(im2);

%% Transormation panoramique
latlon = generateEquiRectImage(im);

%% Composition
%facteur d'illumination
c=5;
final = compose('../web/images/perso3/blender/',c);
imshow(final);
imwrite(final,'final.jpg');