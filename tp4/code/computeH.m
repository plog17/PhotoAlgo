function [ H ] = computeH( im1_pts, im2_pts )
    nbOfPts = size(im1_pts,1);
    A = zeros(2*nbOfPts, 8);
    b = zeros(2*nbOfPts, 1);

    for it = 1:nbOfPts
        A(2*it-1,1) = im2_pts(it,1);
        A(2*it-1,2) = im2_pts(it,2);
        A(2*it-1,3) = 1;
        A(2*it,4) = im2_pts(it,1);
        A(2*it,5) = im2_pts(it,2);
        A(2*it,6) = 1;
        A(2*it,7) = -im1_pts(it,2)*im2_pts(it,1);
        A(2*it,8) = -im1_pts(it,2)*im2_pts(it,2);
        
        A(2*it-1,7) = -im1_pts(it,1)*im2_pts(it,1);
        A(2*it-1,8) = -im1_pts(it,1)*im2_pts(it,2);
        
        b(2*it-1) = im1_pts(it,1);
        b(2*it) = im1_pts(it,2);
    end
    h = A \ b;

    %3x3 with last element = 1
    H = [h(1) h(2) h(3); h(4) h(5) h(6); h(7) h(8) 1];

    
numPts = size(im1_pts,1);

pts1=[im1_pts ones(numPts,1)];
pts2=[im2_pts ones(numPts,1)];

H2=pts1\pts2;
    
    
end

