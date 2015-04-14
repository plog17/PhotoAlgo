function [ final ] = compose( path,c)
    %c=facteur d'illumination

    E = im2double(imread(strcat(path,'rendered_empty.png')));
    M = im2double(imread(strcat(path,'rendered_mask.png')));
    R = im2double(imread(strcat(path,'rendered.png')));
    I = im2double(imread(strcat(path,'background.jpg')));
    
    
    final = M.*R + (1-M).*I + (1-M).*(R-E).*c;
end

