function [outPts] = adaptiveNonMaximalSuppression(im1)

    [x,y,v]=harris(im1);
    ptsR = [x y v zeros(size(x,1))];

    %selon l'article
    cRobust = 0.9;
    nbPtsInterest = 500;

    for i=1:size(x,1)
        ptsT=[x y (cRobust*z)];
        smaller=(ptsT(:,3)<ptsR(i,3));
        ptsT(smaller,:)=[];% filter out all points will smaller value that i
        rs=((ptsT(:,1)-ptsR(i,1)).^2) + ((ptsT(:,2)-ptsR(i,2)).^2);

        ptsR(i,4)=min([rs; size(im1,2)^2]); %if everything is smaller then max value, make big
    end

    ptsR=sortrows(ptsR,-4);
    outPts=ptsR(1:nbPtsInterest,1:2);

    %TEMPO
    outPts=cat(2,x(1:50,:),y(1:50,:));
end