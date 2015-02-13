function batchProcessDynamicProg(pathToImages,rowToDelete,resizeVertically,generateAnimatedGif,logging)
fprintf(strcat('\n\n--->',pathToImages, '\n'));
files = dir(strcat(pathToImages,'*.jpg'));
fileIndex = find(~[files.isdir]);

for imageIndex = 1:length(fileIndex)

    filename = files(fileIndex(imageIndex)).name;
    fprintf(strcat('\n\n--->',filename, '\n'));
    image = imread(strcat(pathToImages,filename));
    image = im2double(image);
    imFinal = image;

    frames={rowToDelete*2};
    tic();

    mask = roipoly(imFinal) * 100;

    [energy,Ix,Iy] = calculateEnergy(imFinal);
    energy=energy+mask;
    cost=energy;
    tracks=energy;

    for deleted=1:rowToDelete
    fprintf('\n---> Deleting row %d of %d',deleted,rowToDelete);
    
    if resizeVertically
        imFinal=imrotate(imFinal,90);
        mask=imrotate(mask,90);
    end
        
        for pixelLine = 1: size(energy,1)           
            if pixelLine==1
                cost(pixelLine,:)=energy(pixelLine,:);
            else
                previousLine=cost(pixelLine-1,:);
                [cost,tracks]=calculateCostForNewLine(pixelLine,previousLine,energy,cost,tracks);
            end
        end
        
        [r, startFromColumn] = find(cost == min(cost(size(cost,1),:)));
        
        [energy,unused]=removeColumnAccordingToBestTrack(startFromColumn,tracks,energy);
        energy(:,1,:)=[];
        
        [imFinal,imGif]=removeColumnAccordingToBestTrack(startFromColumn,tracks,imFinal);
        imFinal(:,1,:)=[];  
      
        if resizeVertically
            imFinal=imrotate(imFinal,-90);
            imGif=imrotate(imGif,-90);
        end
        
        if generateAnimatedGif
            frames=addFrame(frames,imGif,logging);
            frames=addFrame(frames,imFinal,logging);
        end
    end

    if generateAnimatedGif
        fprintf(strcat('\n---> Creating animated gif for ',filename));
        createAnimatedGif(strcat('gifs/',int2str(rowToDelete),'_dynamic_',filename),0,frames,logging);
    end
    
    fprintf(strcat('\n---> Saving jpeg for ',filename));
    imwrite(imFinal,strcat('res/',int2str(rowToDelete),'_dynamic_',filename));
    
    fprintf('\n');
    toc();

end
