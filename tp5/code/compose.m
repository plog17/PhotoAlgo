function [ final ] = compose( path )
    E = im2double(imread(strcat(path,'rendered_empty.png')));
    M = im2double(imread(strcat(path,'rendered_mask.png')));
    R = im2double(imread(strcat(path,'rendered.png')));

   composite = M.*R + (1-M).*I + (1-M).*(R-E).*c
    
end

