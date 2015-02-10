function [energy,Ix,Iy] = calculateEnergy(image)
    imageGray = rgb2gray(image);
    [Ix, Iy] = gradient(imageGray); % first order partials
    energy = abs(Ix) + abs(Iy);
end

