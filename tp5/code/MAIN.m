path='/Users/plauger/git/PhotoAlgo/tp5/web/images/origin/sphere/';
path2='/Users/plauger/git/PhotoAlgo/tp5/web/images/perso2/sphere/';
path3='/Users/plauger/git/PhotoAlgo/tp5/web/images/perso3/sphere/';
numPixels=250;
srow=20;
scol=40;
channels=3;

addpath('tests/program/')
addpath('radiance/')


%% Carte de radiance
im=GenerateHDR(path3,'perso3');
im=GenerateHDR(path,'origin');

%% Transormation panoramique
%linespace(-pi,pi,100);
  %[phis, thetas] = meshgrid([pi:pi/360:2*pi 0:pi/360:pi], 0:pi/360:pi);
  %angle=[phis(:),thetas(:)];
  %[x,y,z]=sph2cart(thetas,phis);

[phis, thetas] = meshgrid([pi:pi/360:2*pi 0:pi/360:pi], pi/2:-pi/360:-pi/2);

%pour obtenir l
angles=[phis(:),thetas(:)];

%l en cartésien 
%on pose r=1
r=1;
[z,x,y]=sph2cart(angles(:,1),angles(:,2),r);
l=[x(:),y(:),z(:)];

%pour obtenir N, on calcul avec R = V - 2 .* dot(V,N) .* N
V=[0 0 1];
Vs=repmat(V,size(l,1),1);

N=l;
for it=1:size(l,1)
    N(it,:) = V - 2 .* dot(V,l(it,:)) .* l(it,:);
end


%on retrouve x,y
[xs,ys] = meshgrid(linspace(-1,1,size(im,2)), linspace(-1,1,size(im,1))); 

latlon = repmat(zeros(size(phis)), [1 1 3]); 
for c=1:3
    latlon(:,:,c)=reshape(interp2(xs,ys,im(:,:,c),N(:,1),N(:,2)),size(latlon,1),size(latlon,2));
end




