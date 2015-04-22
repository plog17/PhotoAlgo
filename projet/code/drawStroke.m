function [ out ] = drawStroke( im,out,xs,ys,angle,cx,cy,strokeWidth,marked )
%%   
if size(xs)>0
    originalColor=im(cy,cx,:);    
    
    if marked
        originalColor(1,1,:)=[255 0 0];
    end

    for i=1:3
        for slice=0:strokeWidth-1
            out(sub2ind(size(out), ys, xs+slice, repmat(i, 1, size(xs,2)))) = originalColor(:,:,i);
        end
    end
end

end

