function [outPts] = adaptiveNonMaximalSuppression(im1)

[x,y,z]=harris(im1);
ptsR = [x y z zeros(size(x,1))];

%selon l'article
cRobust = 0.9;
nbPtsInterest = 500;

for i=1:size(x,1)
    ptsT=[x y (cRobust*z)];
    smaller=(ptsT(:,3)<ptsR(i,3));
    
    % filter out all points will smaller value that i
    ptsT(smaller,:)=[];
    rs=((ptsT(:,1)-ptsR(i,1)).^2) + ((ptsT(:,2)-ptsR(i,2)).^2);
    
    %if everything is smaller then max value, make big
    ptsR(i,4)=min([rs; size(im1,2)^2]);
end

ptsR=sortrows(ptsR,-4); % sorts so largest radius at top

outPts=ptsR(1:nbPtsInterest,1:2);

end