function batchProcessDynamicProg(pathToImages,rowToDelete, logging)
fprintf(strcat('\n\n--->',pathToImages, '\n'));
files = dir(strcat(pathToImages,'*.jpg'));
fileIndex = find(~[files.isdir]);



for imageIndex = 1:length(fileIndex)

    filename = files(fileIndex(imageIndex)).name;
    fprintf(strcat('\n\n--->',filename, '\n'));
    image = imread(strcat(pathToImages,filename));
    image = im2double(image);
    imFinal = image;

    frames={50};
    tic();

    for deleted=1:rowToDelete
        fprintf('\n---> Deleting row %d of %d',deleted,rowToDelete);
        imGif=imFinal;
        [energy,Ix,Iy] = calculateEnergy(imFinal);
        frameCount=size(frames,2)-1;
        pixelColumn=1;
        stopCol=size(energy,2);
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
        [imFinal,imGif]=removeColumnAccordingToBestTrack(startFromColumn,tracks,imFinal);
        imFinal(:,1,:)=[];
        frames=addFrame(frames,imGif,logging);
        frames=addFrame(frames,imFinal,logging);
    end

    fprintf(strcat('\n---> Creating animated gif for ',filename));
    createAnimatedGif(strcat('gifs/',int2str(rowToDelete),'_',filename),0,frames,logging);
    
    fprintf(strcat('\n---> Saving jpeg for ',filename));
    imwrite(imFinal,strcat('res/',int2str(rowToDelete),'_',filename));
    
    fprintf('\n');
    toc();

end
