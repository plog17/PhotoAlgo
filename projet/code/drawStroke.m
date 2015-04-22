function [ out ] = drawStroke( im,out,x1,y1,x2,y2,pts,angle,cx,cy )
    originalColor=im(cy,cx,:);
    red=originalColor;
    red(1,1,:)=[255 0 0];
    
    o=ones(size(pts,1),1);
    ptsR=cat(2,pts,o);
    
    o(:,:)=2;
    ptsG=cat(2,pts,o);
    
    o(:,:)=3;
    ptsB=cat(2,pts,o);
    
    test=zeros(400,640,3);
    test(ptsR)=1;
    test(ptsG)=1;
    test(ptsB)=1;
    imshow(test);
        
end

