function [ N ] = normalVectors( Z )
    [width height channel frames]=size(Z);
   
    N=zeros(width,height,frames);
      
    for curFrame=1:frames
        for x=1:width
            for y=1:height
                curX=-1+x*(2/width);
                curY=-1+y*(2/height);
                z=sqrt(1-(curX^2)-(curY^2)^2);
                N(x,y,curFrame)=z;
            end
        end
    end  
    
end




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
