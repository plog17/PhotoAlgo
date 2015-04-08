function [ w ] = ponderationFunction( Z )
    w=double(128-abs(Z-128));
end

