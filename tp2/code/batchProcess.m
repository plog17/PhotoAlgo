function batchProcess(pathToImages,frequence,logging)
fprintf(strcat('\n\n--->',pathToImages, '\n'));
files = dir(strcat(pathToImages,'*.jpg'));
fileIndex = find(~[files.isdir]);

for imageIndex = 1:length(fileIndex)

    filename = files(fileIndex(imageIndex)).name;
    fprintf(strcat('\n\n--->',filename, '\n'));
    image = imread(strcat(pathToImages,filename));
    image = im2double(image);
    imFinal = image;

    rowToDelete=9;
    frames={50};
    tic();

    for deleted=1:rowToDelete
        fprintf('\n---> Deleting row %d of %d',deleted,rowToDelete);
        imGif=imFinal;
        [energy,Ix,Iy] = calculateEnergy(imFinal);
        frameCount=size(frames,2)-1;
        startCol=1;
        pixelColumn=startCol;
        stopCol=size(energy,2);
        cost=[size(energy,1),size(energy,2),size(energy,1)+size(energy,2)];
        
        for pixelLine = 1: size(energy,1)-1
            minEnergyOnLine=[1,1];
            minEnergy=Inf;
            
            if pixelLine==1
                cost(pixelLine,:)=energy(pixelLine,:);
            else
                previousLine=cost(pixelLine,:);
                cost=calculateCostForNewLine(pixelLine,pixelColumn,previousLine,cost);
            end
            
            for pixelColumn = startCol: stopCol
                if pixelColumn>=1 && pixelLine>=1
                    if Ix(pixelLine,pixelColumn)<minEnergy
                        minEnergy = Ix(pixelLine,pixelColumn);
                        minEnergyOnLine = [pixelLine,pixelColumn];
                    end                  
                end
            end
            
            minEnergyPixelRow=minEnergyOnLine(1,1);
            minEnergyPixelColumn=minEnergyOnLine(1,2);
            
            imGif=colorPixelForGif(imGif,minEnergyPixelRow,minEnergyPixelColumn);
            %frameIndex=frameCount+pixelLine;
            %frames=addFrameByFrequence(frames,imGif,frequence,frameIndex,logging);

            imFinal = shiftPixelRight(imFinal,minEnergyPixelRow,minEnergyPixelColumn,false);

            startCol=minEnergyPixelColumn-1;
            stopCol=minEnergyPixelColumn+1;

        end
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

   % figure(imageIndex);
   % subplot_tight(1,2,1), imshow(image); title('Originale');
   % subplot_tight(1,2,2), imshow(imFinal); title('Modifie');


end
