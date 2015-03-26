function [outPts] = adaptiveNonMaximalSuppression(im1)

    [x,y,v]=harris(im1);
    ptsR = [x y v zeros(size(x,1))];

    %selon l'article
    cRobust = 0.9;
    nbPtsInterest = 500;

    for i=1:size(x,1)

    end

    ptsR=sortrows(ptsR,-4);
    outPts=ptsR(1:nbPtsInterest,1:2);

    %TEMPO
    outPts=cat(2,x(1:50,:),y(1:50,:));
end