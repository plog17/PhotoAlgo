function [ out ] = paint(im,imE,angle,strokeLength,strokeWidth)

%%
out=im;
[heigth, width, c]=size(im);

cx=2*strokeLength;
cy=2*strokeLength;
while cx<(width-2*strokeLength)
    fprintf('\nPrinting cx=%d cy=%d',cx,cy);
    while cy<(heigth-2*strokeLength)
        % with stroke clipping
        [ xs,ys ] = strokeClipping( strokeLength, imE, cx, cy, angle );
        
        %out = drawStroke( im,out,xs,ys,angle,cx,cy, strokeWidth,1 );
        out = drawStroke( im,out,xs,ys,angle,cx,cy, strokeWidth,0 );
        cy=cy+strokeWidth;
   end  
   cx=cx+strokeLength;
   cy=strokeLength;
end


end

