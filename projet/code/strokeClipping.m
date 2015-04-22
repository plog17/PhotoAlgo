function [ x1, y1, x2, y2, pts ] = strokeClipping( strokeLength, imE, cx, cy, angle )

%%
x1=cx;
y1=cy;
x2=cx;
y2=cy;

lastSample=bilinearSampleImageAt(imE,x1,y1);
[dirx diry]=getDirXDirY(angle);
pts=zeros(1,2);
for i=1:ceil(strokeLength/2)
    
    tempx=x1-dirx;
    tempy=y1-diry;

    if pdist([x1,y1;tempx,tempy],'euclidean') > strokeLength
        %stop
        i=ceil(strokeLength/2);
    else
        newSample=bilinearSampleImageAt(imE,tempx,tempy);

        if newSample<lastSample
            %stop
            i=ceil(strokeLength/2);
        else
            x1=tempx;
            y1=tempy;
            pts=[pts;[y1 x1]];
            lastSample=newSample;
        end
    end
end


lastSample=bilinearSampleImageAt(imE,x2,y2);
for i=1:ceil(strokeLength/2)
    tempx=x2+dirx;
    tempy=y2+diry;

    if pdist([x2,y2;tempx,tempy],'euclidean') > strokeLength
        %stop
        i=ceil(strokeLength/2);
    else
        newSample=bilinearSampleImageAt(imE,tempx,tempy);

        if newSample<lastSample
            %stop
            i=ceil(strokeLength/2);
        else
            x2=tempx;
            y2=tempy;
            pts=[pts;[y2 x2]];
            lastSample=newSample;
        end
    end
end

%enlever le point 0,0
pts(1,:)=[];

%%
end

