function batchProcessGreedyFirstChoice(pathToImages,percentage,resizeVertically,generateAnimatedGif,logging)
fprintf(strcat('\n\n--->',pathToImages, '\n'));

files = dir(strcat(pathToImages,'*.jpg'));
fileIndex = find(~[files.isdir]);

for imageIndex = 1:length(fileIndex)

    filename = files(fileIndex(imageIndex)).name;
    fprintf(strcat('\n\n--->',filename, '\n'));
    
    imFinal = imread(strcat(pathToImages,filename));
    imFinal = im2double(imFinal);

    rowToDelete = getRowToDelete(imFinal,percentage,resizeVertically);
    
    frames={rowToDelete*2};
    tic();

    for deleted=1:rowToDelete
        fprintf('\n---> Deleting row %d of %d',deleted,rowToDelete);
          
        if resizeVertically
            imFinal=imrotate(imFinal,90);
        end

        imGif=imFinal;
        [energy,Ix,Iy] = calculateEnergy(imFinal);
        startCol=1;
        stopCol=size(energy,2);
        
        for pixelLine = 1: size(energy,1)-1
            minEnergyOnLine=[1,1];
            minEnergy=Inf;
            for pixelColumn = startCol: stopCol
               if Ix(pixelLine,pixelColumn)<minEnergy
                minEnergy = Ix(pixelLine,pixelColumn);
                minEnergyOnLine = [pixelLine,pixelColumn];
               end
            end
            
            minEnergyPixelRow=minEnergyOnLine(1,1);
            minEnergyPixelColumn=minEnergyOnLine(1,2);
            
            imGif = colorPixelForGif(imGif,minEnergyPixelRow,minEnergyPixelColumn);
            imFinal = shiftPixelRight(imFinal,minEnergyPixelRow,minEnergyPixelColumn,false);

            startCol=minEnergyPixelColumn-1;
            stopCol=minEnergyPixelColumn+1;
            
            if startCol<1
                startCol=1;
            end
            
            
        end
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
        createAnimatedGif(strcat('gifs/',int2str(rowToDelete),'_greedy_',filename),0,frames,logging);
    end
    
    fprintf(strcat('\n---> Saving jpeg for ',filename));
    imwrite(imFinal,strcat('res/',int2str(rowToDelete),'_greedy_',filename));
    
    fprintf('\n');
    toc();

end
