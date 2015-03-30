function [ descriptors ] = extractDescriptor( im, pts )
    %selon article   
    space=5;
    descriptors=zeros(size(pts,1),64);

    % filtrer l'image
    gaussianFilter=fspecial('gaussian', 10, 1.5);
    im2=imfilter(im, gaussianFilter);
    
    [FX,FY]=gradient(im2);

    for i=1:size(pts,1)
        grad=[FX(pts(i,2),pts(i,1)) FY(pts(i,2),pts(i,1))];
        grad=grad./norm(grad);
        gradP=[grad(2) -grad(1)];

        ptsForDesc=[];
        for x=-3:4
            for y=-3:4
                p=pts(i,:)+((x*space)*gradP+(y*space)*gradP);
                ptsForDesc=[ptsForDesc; p];
            end
        end

        ptsForDesc(:,1)=min(max(ptsForDesc(:,1),1), size(im,2));
        ptsForDesc(:,2)=min(max(ptsForDesc(:,2),1), size(im,1));
        ptsForDesc=int64(ptsForDesc);

        X=im2(sub2ind(size(im2), ptsForDesc(:,2), ptsForDesc(:,1)));
        
        %Tel que dans l'article
        %mean 0
        X=X-mean(X(:));
        %standard deviation 1
        X=X./std(X(:));

        
        descriptors(i,:)=X;
    end

end

