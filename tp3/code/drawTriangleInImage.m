function [ J ] = drawTriangleInImage( findedTri2,image1 )
    shapeInserter = vision.ShapeInserter('Shape','Polygons','BorderColor','Custom', 'CustomBorderColor', uint8([255 0 0]));
    triangle = int32([findedTri2(1,1) findedTri2(1,2) findedTri2(2,1) findedTri2(2,2) findedTri2(3,1) findedTri2(3,2)]);
    J = step(shapeInserter, image1, triangle);
    imshow(J); 
end

