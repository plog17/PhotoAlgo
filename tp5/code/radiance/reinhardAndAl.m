function [ imOut ] = reinhardAndAl( im )
    C=.75;
    imOut=C*im./(1+im);
    
%    index = find(isnan(imOut) | isinf(imOut));
 %   imOut(index) = 0;
end

