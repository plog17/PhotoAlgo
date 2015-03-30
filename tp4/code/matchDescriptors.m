function [ im1match,im2match ] = matchDescriptors(im1pts, im1desc, im2pts, im2desc)
   
    % selon l'article, c'est le ratio le plus optimal (image 6b)
    squarredErrorLimit=.6;
    
    % calculer distance
    distances=dist2(im1desc,im2desc); 
    [neighbor1, indexes]=min(distances);

    % remplacer toutes les valeurs min trouvées par inf
    % pour refaire le calcul et obtenir les 2e plus proches voisins
    distances(sub2ind(size(distances),indexes,1:size(im1pts,1))) = inf;
    neighbor2=min(distances);

    % calculer le ration de la distance avec les premiers voisins et les 2e
    % voisins
    ratio = neighbor1./neighbor2;

    matchPairs=[1:size(im1pts,1) ; indexes ; ratio];

    % eliminer les matchs ne respectant pas la limite
    badMatches = (matchPairs(3,:)>squarredErrorLimit);
    matchPairs(:,badMatches)=[];

    im1match=im1pts(matchPairs(1,:),:);
    im2match=im2pts(matchPairs(2,:),:);
end

