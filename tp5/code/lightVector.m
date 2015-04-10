function [ R ] = lightVector( N )
    [width height frames]=size(N);
      
    % v=[0 0 1] pointe vers la caméra tout le temps, projection orthographique
    V=[0 0 1];
    R=zeros(width, height, frames);
    
    N(imag(N) ~= 0) = .5;
    
    for curFrame=1:frames
        for x=1:width-1
            for y=1:height-1
                curNx=-1+x*(2/width);
                curNy=-1+y*(2/height);
                curNz=N(x,y,curFrame);
                
                N=[curNx curNy curNz];
                R(x,y,curFrame) = V - 2 .* dot(V,N) .* N;
            end
        end
    end
    
    
    

    
    
end

%linespace(-pi,pi,100);
  %[phis, thetas] = meshgrid([pi:pi/360:2*pi 0:pi/360:pi], 0:pi/360:pi);
  %angle=[phis(:),thetas(:)];
  %[x,y,z]=sph2cart(thetas,phis);
    
% v=[0 0 1] pointe vers la caméra tout le temps, projection orthographique
% n, dépend de la position dans l'image, on assume sphère unitaire, rayon=1
%   donc x=[-1,1],y[-1,1],z=> norme unitaire: isole z dans sqrt(x2+y2+z2)=1
%   on trouve l (coord. cartésiennes) avec la formule dans les notes

% convertir l en coor. sphérique


% 1) (u,v) > n
% 2) n,v > l
% 3) l > (theta, phi)
% on refait l'inverse pour trouver la transformation qui nous ramene a la
% source et interpoler