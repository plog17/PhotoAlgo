function [outPts] = adaptiveNonMaximalSuppression(im1)
    %selon l'article
    cRobust = 1/0.9;
    nbPtsInterest = 500;

    [x,y,v]=harris(im1);
    
    % 4e colonne pour garder la trace du rayon minimisant
    ptsR = [x y v zeros(size(x))];
    
    % trier et garder le point le plus fort
    ptsR = sortrows(ptsR,-3);    
    
    for currentRow=1:size(x,1)
        % on applique le facteur cRobust aux autres points
        otherPoints=[x y (cRobust*v)];
      
        % On enlève tout ce qui n'est pas assez fort comme coin
        smallerCornerIndexes=(otherPoints(:,3)<ptsR(currentRow,3));
        otherPoints(smallerCornerIndexes,:)=[];
        
        % On calcul la distance du point courrant vs tous les autres
        currentPoints=ptsR(currentRow,1:2);
        rs=dist2(currentPoints,otherPoints(:,1:2))';
        
        % si dist=0, on est sur le meme point, on doit corriger
        rs(rs==0)=inf;
        
        % on garde la minimisation dans la 4e colonnne
        ptsR(currentRow,4)=min(rs);
    end

    ptsR=sortrows(ptsR,4);
    outPts=ptsR(1:nbPtsInterest,1:2);    
    
    % show 'em
    imagesc(im1);
    colormap(gray);
    hold on;
    plot(outPts(:,1),outPts(:,2),'r.');
    hold off;
end