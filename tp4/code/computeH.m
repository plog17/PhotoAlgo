function [ H ] = computeH( im1_pts, im2_pts )
    A = zeros(4,9);
    O = [0 0 0];
    for i = 1 : 4;
        %setup matrix values
        X = im1_pts(:,i)';
        x = im2_pts(1,i); 
        y = im2_pts(2,i); 
        w = im2_pts(3,i);
        A(3*i-2,:) = [  O  -w*X  y*X];
	    A(3*i-1,:) = [ w*X   O  -x*X];
	    A(3*i  ,:) = [-y*X  x*X   O ];
    end;
    
    %solve system
    [U,S,V] = svd(A,0);
    %get homography
    H = reshape(V(:,9),3,3)';
    H = H/H(3,3); 


end

