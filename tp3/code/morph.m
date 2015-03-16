function morphed = morph(image1, image2, pts1, pts2, tri, warp_frac, dissolve_frac)
%init
[h,w,number_ch] = size(image1);  
morphed = ones(h, w, number_ch);

%create mesh grid for mtsearch
[X,Y] = meshgrid(1:w, 1:h);
ind_array = cell(number_ch, 1);

% convert subscripts to linear indices
for ch = 1:number_ch
    ind_array{ch} = sub2ind([h,w,number_ch], Y(:), X(:), ones(h*w,1)*ch);
end

% find the middle image
intermediate = pts1 + warp_frac*(pts2 - pts1);

%work on array is simpler to me
image1_array{size(tri,1)} = [];
inter_array{number_ch, size(tri,1)} = [];
final_array{size(tri,1), 1} = [];

% find the triangles match
triangle = mytsearch(intermediate(:,1), intermediate(:,2), tri, X(:), Y(:));

% find the transformations
for i = 1:size(tri,1)
    T1 = getTransformationMatrix(tri(i,:),intermediate,pts1);
    T2 = getTransformationMatrix(tri(i,:),intermediate,pts2);
    
    %find matchs
    matchs=find(triangle==i);
    matchsConcat = [X(matchs), Y(matchs), ones(length(matchs),1)];
    
    image1_array{i} = T1*matchsConcat';
    final_array{i} = T2*matchsConcat';
    
    %work on all channels
    for k = 1:number_ch
        inter_array{k,i} = ind_array{k}(matchs);
    end
end


% interpolate  
image1_array = cat(2, image1_array{:});
final_array = cat(2, final_array{:});
for c = 1:number_ch
    morphed(cat(1,inter_array{c,:})) = (1-dissolve_frac)*interp2( image1(:,:,c), image1_array(1,:), image1_array(2,:))+ dissolve_frac*interp2(image2(:,:,c), final_array(1,:), final_array(2,:));
end

end