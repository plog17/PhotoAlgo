function [ w ] = ponderationFunction()
    ZmaxHalf=128;
    Zs = 1:256;

    w=double(ZmaxHalf-abs(Zs-ZmaxHalf));
end

