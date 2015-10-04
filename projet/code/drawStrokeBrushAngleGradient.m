function [ out,painted ] = drawStrokeBrushAngleGradient( im,out,painted,xs,ys,cx,cy,strokeWidth,marked,random,brush )
%%

if size(xs)>0
    
    if random
        originalColor=out(cy,cx,:);    
    else
        originalColor=im(cy,cx,:); 
    end
    if marked
        originalColor(1,1,:)=[255 0 0];
    end

    for i=1:3
        for slice=1:strokeWidth
            out(sub2ind(size(out), ys, xs+slice-1, repmat(i, 1, size(xs,2)))) = (im(cy+brush(1:size(xs),slice)',cx,i)+out(cy+brush(1:size(xs),slice)',cx,i))/2;
            painted(sub2ind(size(out), ys, xs+slice-1, repmat(i, 1, size(xs,2)))) = painted(sub2ind(size(out), ys, xs+slice-1, repmat(i, 1, size(xs,2))))+.05;
        end
        
        %create some overlap
        if random
            out(ys(size(ys,2)),xs(size(xs,2)),:) = originalColor(:,:,:);
            painted(sub2ind(size(out), ys, xs+slice, repmat(i, 1, size(xs,2)))) = painted(sub2ind(size(out), ys, xs+slice, repmat(i, 1, size(xs,2))))+.05;
        end
    end
end

end

