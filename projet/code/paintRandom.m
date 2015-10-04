function [ out,painted ] = paintRandom(im,imE,angle,strokeLength,strokeWidth,meshxs,meshys)

%%
out=zeros(size(im));
painted=zeros(size(im));
[heigth, width, c]=size(im);

cx_ar{10}=[];
cy_ar{10}=[];
xs_ar{10}=[];
ys_ar{10}=[];


%% Calculer tous les coup de pinceaux
cx=2*strokeLength;
cy=2*strokeLength;
strokeId=1;
while cx<(width-2*strokeLength)
    fprintf('\nCalculating stroke cx=%d cy=%d',cx,cy);
    while cy<(heigth-2*strokeLength)
        [ xs,ys ] = strokeClipping( strokeLength, imE, cx, cy, angle,meshxs,meshys );
        
        cx_ar{strokeId}=cx;
        cy_ar{strokeId}=cy;
        xs_ar{strokeId}=xs;
        ys_ar{strokeId}=ys;
        
        cy=cy+strokeWidth;
        strokeId=strokeId+1;
   end  
   cx=cx+3;%strokeLength;
   cy=strokeLength;
   
end

%% Les appliquer au hasard
el=1:size(cx_ar,2);
elS=el(randperm(numel(el)));

for i=1:size(cx_ar,2)
    xs=xs_ar{elS(i)};
    ys=ys_ar{elS(i)};
    cx=cx_ar{elS(i)};
    cy=cy_ar{elS(i)};
    [out,painted] = drawStrokeBrush( im,out,painted,xs,ys,cx,cy, strokeWidth,0,1); 
    fprintf('%d of %d\n',i,size(cx_ar,2));
end

%normaliser
painted=painted./max(painted(:));

end

