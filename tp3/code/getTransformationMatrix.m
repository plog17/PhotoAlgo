function [ T ] = getTransformationMatrix( currentTri, image, pts1)
    triX=image(currentTri,1);
    triY=image(currentTri,2);
    
    b = [triX, triY, ones(3,1)]';
    A = [pts1(currentTri,1), pts1(currentTri,2), ones(3,1)]';
    T=A/b;
end

