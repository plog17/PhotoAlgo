function [outH, bestError] = ransac(im1pts, im2pts, maxIt, permittedError)
%RANSAC performs RANSAC to further remove outliers then compute H.
% Also returns how many points were ultimately used. 

bestModel;
bestPoints;

bestNumMatches=0;
bestError=inf;

for i=1:maxIt
    %choisir des points au hazard
    randomPts= randperm(size(im1pts,1),4); 
    src_pts = im1pts(randomPts,:);
    dest_pts = im2pts(randomPts,:);
    
    H_temp = computeH(src_pts, dest_pts);
    
    % Avoir Nx3 pour match des dimensions
    im1pts_1=cat(2,im1pts,ones(size(im1pts,1),1));
     
    % appliquer l'homographie
    testsPts = im1pts_1 * H_temp;
    
    % tester la qualité de l'homographie en évaluant l'erreur
    currentError = (im2pts(:,1)-testsPts(:,1)).^2 + (im2pts(:,2)-testsPts(:,2)).^2;
    
    [x,~,~] = find(currentError < permittedError);
    currentNbMatches = size(x,1);

    if currentNbMatches > bestNumMatches
        fprintf('%d',currentNbMatches);
        if currentError < bestError
            outH = H_temp;
            bestNumMatches = currentNbMatches;
            bestError=currentError;
        end
    end
end

end