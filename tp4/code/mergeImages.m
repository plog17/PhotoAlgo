function [ outIm ] = mergeImages( referenceImage, appendedImage, xOffset, yOffset ) 
    [rows,cols,~] = size(referenceImage);
    
    min_row = 1;
    min_col = 1;
    max_row = 0;
    max_col = 0;
    
    % create a matrix with the coordinates of the four corners of the
    % current image
    pt_matrix = cat(3, [1,1,1]', [1,cols,1]', [rows, 1,1]', [rows,cols,1]');
    
    % Map each of the 4 corner's coordinates into the coordinate system of
    % the reference image
    for j = 1:4
        result = H*pt_matrix(:,:,j);
        
        min_row = floor(min(1, result(1)));
        min_col = floor(min(1, result(2)));
        max_row = ceil(max(0, result(1)));
        max_col = ceil(max(0, result(2)));
    end

    
    
     % Calculate output image size
    im_rows = max_row - min_row + 1;
    im_cols = max_col - min_col + 1;

    % Calculate offset of the upper-left corner of the reference image relative
    % to the upper-left corner of the output image
    row_offset = 1 - min_row;
    col_offset = 1 - min_col;

    % Initialize output image to black (0)
    pan_image = zeros(im_rows, im_cols, 3);

    % weight vector
    weight_pan = 1 : -1/(im_cols-1) : 0;
    % weight matrix: repeat of weight vector
    weight_matrix = repmat(weight_pan, im_rows, 1);
    % weight vector
    weight_pan2 = 1 - weight_pan;
    % weight matrix: repeat of weight vector
    weight_matrix2 = repmat(weight_pan2, im_rows, 1);
    
    

    [width height channels]=size(appendedImage);    
    outIm = zeros(width+xOffset,height+yOffset,3);
    
    [width height channels]=size(outIm); 
    for x=1:width
        for y=1:height
            if x>size(referenceImage,1) || y>size(referenceImage,2)
                outIm(x,y,:)=appendedImage(x-xOffset,y-yOffset,:);
            else
            if ((x-xOffset)<1) || ((y-yOffset)<1)
                outIm(x,y,:)=referenceImage(x,y,:);
            else
                if isnan(appendedImage(x,y,1))
                   outIm(x,y,:)=referenceImage(x,y,:);
                else
                   outIm(x,y,:)=appendedImage(x-xOffset,y-yOffset,:);
                end
            end
            end
        end
    end
end

