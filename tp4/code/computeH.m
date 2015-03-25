function [ H ] = computeH( im1_pts, im2_pts )
    nbPts = size(im1_pts,1);
    filler=ones(nbPts,1);
    pts1_aug=[im1_pts filler];
    pts2_aug=[im2_pts filler];

    %1 au coin en bas à droite
    H=pts1_aug\pts2_aug;   
end

