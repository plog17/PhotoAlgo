function [ lastSample ] = bilinearSampleImageAt( im,cx,cy )
    [height width]=size(im);
    [xs ys]=meshgrid(1:width,1:height);

    lastSample=interp2(xs,ys,im,cx,cy);
end

