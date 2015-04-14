path='../web/images/origin/sphere/';
path3='../web/images/perso3/sphere/';
numPixels=250;
srow=20;
scol=40;
channels=3;

addpath('tests/program/')
addpath('radiance/')


%% Carte de radiance
im=GenerateHDR(path3,'perso3');
im2=GenerateHDR(path,'origin');

%% Transormation panoramique
latlon = generateEquiRectImage(im);

%% Composition
final = compose('../web/images/perso3/blender/');