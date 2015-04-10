function [ imOut ] = reinhardAndAl( im )
    C=.75;
    imOut=C*im./(1+im);
    imshow(imOut);
end

