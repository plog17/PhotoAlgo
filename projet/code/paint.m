function [ out ] = paint(im,imE,angle)

%%
strokeLength=10;
strokeWidth=3;
out=im;
[heigth, width, c]=size(im);

cx=strokeLength;
cy=strokeLength;
while cx<(width-2*strokeLength)
   while cy<(heigth-2*strokeLength)
        fprintf('\nPrinting cx=%d cy=%d',cx,cy);
        % with stroke clipping
        [ x1, y1, x2, y2, pts ] = strokeClipping( strokeLength, imE, cx, cy, angle );
        length=pdist([x2,y2;x1,y1],'euclidean');
        out = drawStroke( im,out,x1,y1,x2,y2,angle,cx,cy, strokeWidth );
        cy=cy+strokeWidth;
   end  
   cx=cx+strokeLength;
   cy=strokeLength;
end


end

