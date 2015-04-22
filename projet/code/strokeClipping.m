function [ xs, ys ] = strokeClipping( strokeLength, imE, cx, cy, angle )

%%
x1=cx;
y1=cy;
x2=cx;
y2=cy;

lastSample=bilinearSampleImageAt(imE,x1,y1);
[dirx, diry]=getDirXDirY(angle);
xs=cx;
ys=cy;
i=1;
while i<ceil(strokeLength/2)
    
    tempx=x1+dirx;
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
            xs=[xs, x1];
            ys=[ys, y1];
            lastSample=newSample;
        end
    end
    i=i+1;
end


lastSample=bilinearSampleImageAt(imE,x2,y2);

i=1;
while i<ceil(strokeLength/2)
    tempx=x2-dirx;
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
            xs=[xs, x2];
            ys=[ys, y2];
            lastSample=newSample;
        end
    end
    i=i+1;
end

xs=round(xs);
ys=round(ys);
end

