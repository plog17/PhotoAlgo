function [ output ] = warpImage( im,H )

% Create a list of all pixels' coordinates in output image
    [x,y] = meshgrid(1:size(im,2),1:size(im,1));

    % Create list of all row coordinates and column coordinates in separate
    % vectors, x and y, including offset
    x = reshape(x,1,[]) ;%- col_offset;
    y = reshape(y,1,[]) ;%- row_offset;
    
    % Create homogeneous coordinates for each pixel in output image
    pan_pts(1,:) = y;
    pan_pts(2,:) = x;
    pan_pts(3,:) = ones(1,size(pan_pts,2));
    
    % Perform inverse warp to compute coordinates in current input image
    
    image_coords = H\pan_pts;
    
    row_coords = reshape(image_coords(1,:),size(im,2), size(im,1));
    col_coords = reshape(image_coords(2,:),size(im,2), size(im,1));
    
    %interpolate color values
    pixel_color_r = interp2(im(:,:,1), col_coords, row_coords, 'linear', 0);
    pixel_color_g = interp2(im(:,:,2), col_coords, row_coords, 'linear', 0);
    pixel_color_b = interp2(im(:,:,3), col_coords, row_coords, 'linear', 0);
        
    t=cat(3,pixel_color_r,pixel_color_g,pixel_color_b);
end

