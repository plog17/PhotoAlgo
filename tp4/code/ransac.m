function [H, bestError] = ransac(im1pts, im2pts, maxIt, permittedError)
%RANSAC performs RANSAC to further remove outliers then compute H.
% Also returns how many points were ultimately used. 

numMatches=0;
bestError=inf;

for i=1:maxIt
    randomPts= randperm(size(im1pts,1),4); 
    src_pts = im1pts(randomPts,:);
    dest_pts = im2pts(randomPts,:);
    
    H_temp = computeH(im1pts, im2pts);
    testsPts = impts1*H_temp;
    
    currentError = sqrt(sum(((testsPts-Xd).^2),2));
    [x,~,~] = find(currentError < permittedError);
    currentMatches = size(x,1);

    if currentMatches > numMatches

        if currentError < bestError
            H = H_temp;
            numMatches = currentMatches;
            bestError=currentError;
        end
    end
end

possibleModel=computeH(im1pts(ptsUsed,:), im2pts(ptsUsed,:));
H=possibleModel;
end