function [energy,Ix,Iy] = calculateEnergy(image)
    imageGray = rgb2gray(image);
    try
    [Ix, Iy] = gradient(imageGray); % first order partials
    catch e
        imageGrayp=imageGray
    end
    
    energy = abs(Ix) + abs(Iy);
    %energy = Ix.^2 + Iy.^2;
end

