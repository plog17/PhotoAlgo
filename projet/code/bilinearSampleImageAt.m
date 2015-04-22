function [ lastSample ] = bilinearSampleImageAt( imE,cx,cy )
%%    
    [height width]=size(imE);
    [xs ys]=meshgrid(1:width,1:height);

    lastSample=interp2(xs,ys,imE,cx,cy);
end

