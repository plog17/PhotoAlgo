function [ out ] = drawStroke( im,out,x1,y1,x2,y2,angle,cx,cy,strokeWidth )
    originalColor=im(cy,cx,:);
    red=originalColor;
    red(1,1,:)=[255 0 0];

    
    for it=0:x2-x1
        out(y1+it,x1+it,:)=originalColor;       
        for curStroke=1:strokeWidth
            out(y1+it+curStroke,x1+it,:)=originalColor;
        end
    end
    
end

