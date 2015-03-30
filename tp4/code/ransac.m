function [outH, bestError] = ransac(im1pts, im2pts, maxIt, permittedError)

    numMatches=0;
    ptsUsed=[];

    pts11=[im1pts ones(size(im1pts,1),1)];

    for i=1:maxIt 
        currentPts= randperm(size(im1pts,1),4);

        H=computeH(im1pts(currentPts,:), im2pts(currentPts,:));


        ptsTmp=pts11*H;

        ds=(im2pts(:,1)-ptsTmp(:,1)).^2 + (im2pts(:,2)-ptsTmp(:,2)).^2;

        ds=[ds [1:size(im1pts,1)]'];
        ds(ds(:,1)>permittedError,:)=[];

        if size(ds,1)>numMatches 
            numMatches=size(ds,1);
            ptsUsed=ds(:,2)
        end
    end

    outH=computeH(im1pts(ptsUsed,:), im2pts(ptsUsed,:))
end