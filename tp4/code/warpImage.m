function [ imwarped ] = warpImage( im,H )
    [height width channels]=size(im);
    
    %calculer les coins
    topLeft=[1 1 1]/H;
    topRight=[width 1 1]/H;
    bottomLeft=[1 height 1]/H;
    bottomRight=[width height 1]/H;
    minX=floor(min([topLeft(1) topRight(1) bottomLeft(1) bottomRight(1)]));
    minY=floor(min([topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]));
    maxX=ceil(max([topLeft(1) topRight(1) bottomLeft(1) bottomRight(1)]));
    maxY=ceil(max([topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]));
    
    %gap
    ys=maxY-minY+1;
    xs=maxX-minX+1;

    inter(:,:,1)=repmat(minX:maxX, ys, 1);
    inter(:,:,2)=repmat((minY:maxY)', 1, xs);
    inter(:,:,3)=ones(ys, xs);

    % truc de pro: vectoriser l'image en un vecteur de Nx3 (N = # de pixels)
    interVec = reshape(inter, size(inter,1)*size(inter,2), size(inter,3));
    
    % appliquer l'homographie
    interWarped = interVec * H;
    
    % re-convertissons en format "image"
    inter = reshape(interWarped, size(inter,1), size(inter,2), size(inter,3));

    
    %interpolation sur tous les canaux
    imwarped(:,:,1) = interp2(im(:,:,1), inter(:,:,1), inter(:,:,2));
    imwarped(:,:,2) = interp2(im(:,:,2), inter(:,:,1), inter(:,:,2));
    imwarped(:,:,3) = interp2(im(:,:,3), inter(:,:,1), inter(:,:,2));
    
    %imshow(imwarped);
end

