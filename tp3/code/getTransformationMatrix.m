function [ T ] = getTransformationMatrix( tri1, tri2 )
    A = [tri1(1,1),tri1(1,2),1,0,0,0;0,0,0,tri1(1,1),tri1(1,2),1;tri1(2,1),tri1(2,2),1,0,0,0;0,0,0,tri1(2,1),tri1(2,2),1;tri1(3,1),tri1(3,2),1,0,0,0;0,0,0,tri1(3,1),tri1(3,2),1];
    B = [tri2(1,1);tri2(1,2);tri2(2,1);tri2(2,2);tri2(3,1);tri2(3,2)];
    param = pinv(A)*B;
    
    T = [param(1),param(2),param(3);param(4),param(5),param(6);0,0,1];
end

