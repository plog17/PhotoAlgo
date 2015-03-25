function [ imwarped ] = warpImage( im,H )
    [height width channels]=size(im);
    
    %corners
    topLeft=[1 1 1]/H;
    topRight=[width 1 1]/H;
    bottomLeft=[1 height 1]/H;
    bottomRight=[width height 1]/H;
    minX=floor(min([topLeft(1) topRight(1) bottomLeft(1) bottomRight(1)]));
    minY=floor(min([topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]));
    maxX=ceil(max([topLeft(1) topRight(1) bottomLeft(1) bottomRight(1)]));
    maxY=ceil(max([topLeft(2) topRight(2) bottomLeft(2) bottomRight(2)]));
    
    % truc de pro: vectoriser l'image en un vecteur de Nx3 (N = # de pixels)
    imgVec = reshape(im, size(im,1)*size(im,2), size(im,3));
    %points=reshape(points, [ys,3,xs]);
    %for(x=1:xs)
    %    points(:,:,x)=points(:,:,x)*H;
    %end
    
    imgVec = imgVec * H;
    
    %points=reshape(points, [ys,xs,3]);
    % re-convertissons en format "image"
    imgWb = reshape(imgVec, size(im,1), size(im,2), size(im,3));

    outIm(:,:,1) = interp2(image(:,:,1), points(:,:,1), points(:,:,2));
    outIm(:,:,2) = interp2(image(:,:,2), points(:,:,1), points(:,:,2));
    outIm(:,:,3) = interp2(image(:,:,3), points(:,:,1), points(:,:,2));
    
end

