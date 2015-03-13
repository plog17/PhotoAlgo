function [ T ] = getIntermediateTriangle( tri1,tri2 )
    c1 = [(tri1(1,1)+tri2(1,1))/2,(tri1(1,2)+tri2(1,2))/2];
    c2 = [(tri1(2,1)+tri2(2,1))/2,(tri1(2,2)+tri2(2,2))/2];
    c3 = [(tri1(3,1)+tri2(3,1))/2,(tri1(3,2)+tri2(3,2))/2];

    T = [c1;c2;c3];
end

