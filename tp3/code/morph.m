function morphed = morph(source, target, origin_pts, target_pts, tri, warp_frac, dissolve_frac)
[h,w,number_ch] = size(source);  

%create mesh grid for mtsearch
[X,Y] = meshgrid(1:w, 1:h);
ind_array = cell(number_ch, 1);

% convert subscripts to linear indices
for ch = 1:number_ch
    ind_array{ch} = sub2ind([h,w,number_ch], Y(:), X(:), ones(h*w,1)*ch);
end

% find the middle
middle = origin_pts + warp_frac*(target_pts - origin_pts);

%define local arrays
morphed = ones(h, w, number_ch);
source_array = cell(size(tri,1), 1);
destination_array = cell(size(tri,1), 1);
inter_array = cell(number_ch, size(tri,1));

% find the triangles match
triangle = mytsearch(middle(:,1), middle(:,2), tri, X(:), Y(:));

% find the transformations
for i = 1:size(tri,1)
    X_inverse = inv([middle(tri(i,:),1), middle(tri(i,:),2), ones(3,1)]');
    
    XY1 = [origin_pts(tri(i,:),1), origin_pts(tri(i,:),2), ones(3,1)]' * X_inverse;
    XY2 = [target_pts(tri(i,:),1), target_pts(tri(i,:),2), ones(3,1)]' * X_inverse;
    
    trans_found=find(triangle==i);
    
    inverse = [X(trans_found), Y(trans_found), ones(length(trans_found),1)]';
    source_array{i} = XY1*inverse;
    destination_array{i} = XY2*inverse;
    
    for k = 1:number_ch
        inter_array{k,i} = ind_array{k}(trans_found);
    end
end


% interpolate  
source_array = cat(2, source_array{:});
destination_array = cat(2, destination_array{:});
for c = 1:number_ch
    morphed(cat(1,inter_array{c,:})) = (1-warp_frac)*interp2( source(:,:,c), source_array(1,:), source_array(2,:), '*cubic', 1 )+ warp_frac*interp2(target(:,:,c), destination_array(1,:), destination_array(2,:), '*cubic', 1 );
end

end