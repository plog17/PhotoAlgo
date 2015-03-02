function batchProcessDynamicProg(pathToImages,percentage,resizeVertically,generateAnimatedGif,selectROI,logging)
fprintf(strcat('\n\n--->',pathToImages, '\n'));
files = dir(strcat(pathToImages,'*.jpg'));
fileIndex = find(~[files.isdir]);


for imageIndex = 1:length(fileIndex)

    filename = files(fileIndex(imageIndex)).name;
    fprintf(strcat('\n\n--->',filename, '\n'));
    image = imread(strcat(pathToImages,filename));
    image = im2double(image);
    imFinal = image;

    rowToDelete = getRowToDelete(imFinal,percentage,resizeVertically);
    
    if selectROI
        mask = roipoly(imFinal) * 100;
        imwrite(mask,strcat('mask','_',int2str(percentage),filename));
    else
        mask = zeros(size(image,1),size(image,2));
    end

    frames={rowToDelete*2};
    tic();

    rotated=false;
    for deleted=1:rowToDelete

        if resizeVertically && not(rotated)
            imFinal=imrotate(imFinal,90);
            mask=imrotate(mask,90);
            rotated=true;
        end
        fprintf('\n---> Deleting row %d of %d',deleted,rowToDelete);
        [energy,Ix,Iy] = calculateEnergy(imFinal);
        energy=energy+mask;
        
        cost=energy;
        tracks=energy;

        for pixelLine = 1: size(energy,1)
            if pixelLine==1
                cost(pixelLine,:)=energy(pixelLine,:);
            else
                previousLine=cost(pixelLine-1,:);
                [cost,tracks]=calculateCostForNewLine(pixelLine,previousLine,energy,cost,tracks);
            end
        end

        [r, startFromColumn] = find(cost == min(cost(size(cost,1),:)));
        tic();
        [imFinal,imGif]=removeColumnAccordingToBestTrack(startFromColumn,tracks,imFinal);
        toc();
        imFinal(:,1,:)=[];

        if selectROI
            [mask,unused]=removeColumnAccordingToBestTrack(startFromColumn,tracks,mask);
        end
        mask(:,1,:)=[];

        if resizeVertically && generateAnimatedGif
            imFinal=imrotate(imFinal,-90);
            imGif=imrotate(imGif,-90);
            mask=imrotate(mask,-90);
            rotated=false;
        end

        if generateAnimatedGif
            frames=addFrame(frames,imGif,logging);
            frames=addFrame(frames,imFinal,logging);
        end
        
        if mod(deleted,(floor(rowToDelete/3))) == 0
            fprintf(strcat('\n---> Creating animated gif for ',filename));
            createAnimatedGif(strcat('gifs/',int2str(floor(percentage*deleted/rowToDelete)),'_',int2str(selectROI),'_',int2str(resizeVertically),'_dynamic_',filename),0,frames,logging);

            fprintf(strcat('\n---> Saving jpeg for ',filename));
            imwrite(imFinal,strcat('res/',int2str(floor(percentage*deleted/rowToDelete)),'_',int2str(selectROI),'_',int2str(resizeVertically),'_dynamic_',filename));
        end
        
    end


    fprintf('\n');
    toc();

end
