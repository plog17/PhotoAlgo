function [ lastSample ] = bilinearSampleImageAt( imE,cx,cy,meshxs,meshys )
    lastSample=interp2(meshxs,meshys,imE,cx,cy);
end