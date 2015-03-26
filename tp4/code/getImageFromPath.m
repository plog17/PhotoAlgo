function [ im ] = getImageFromPath( path )
    im=im2double(imread(path));
end

