function [ out,painted ] = drawStrokeBrush( im,out,painted,xs,ys,cx,cy,strokeWidth,marked )
%%

% ordonner les pixels à colorier
[xs,ind]=sort(xs);
ys(ind);

%spliter le trait en 3
nbChunk=3;
xs=reshape(xs,size(xs,2)/nbChunk,nbChunk);
ys=reshape(ys,size(ys,2)/nbChunk,nbChunk);


%%
if size(xs,1)>0
    
    originalColor=im(cy,cx,:); 
   
    if marked
        originalColor(1,1,:)=[255 0 0];
    end

    for i=1:3
        for chunk=1:nbChunk
            for slice=0:strokeWidth-1
                tempXS=xs+slice;
                out(sub2ind(size(out), ys(chunk,:), tempXS(chunk,:), repmat(i, 1, size(xs,2)))) = out(cy,cx,:);
                %painted(sub2ind(size(out), ys(chunk,:), tempXS, repmat(i, 1, size(xs,2)))) = painted(sub2ind(size(out), ys, xs+slice, repmat(i, 1, size(xs,2))))+.05;
            end
        end
    end
end

end

