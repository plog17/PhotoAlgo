function [ out,painted ] = paint(im,imE,angle,strokeLength,strokeWidth,meshxs,meshys)

%%
out=im;
painted=zeros(size(im));
[heigth, width, c]=size(im);

cx=2*strokeLength;
cy=2*strokeLength;
while cx<(width-2*strokeLength)
    fprintf('\nPrinting cx=%d cy=%d',cx,cy);
    while cy<(heigth-2*strokeLength)
        % with stroke clipping
        [ xs,ys ] = strokeClipping( strokeLength, imE, cx, cy, angle,meshxs,meshys );
        
        %out = drawStroke( im,out,xs,ys,angle,cx,cy, strokeWidth,1 );
        [out,painted] = drawStroke( im,out,painted,xs,ys,cx,cy, strokeWidth,0,0 );
        cy=cy+strokeWidth;
   end  
   cx=cx+strokeLength;
   cy=strokeLength;
end


end

