function batchProcess(pathToImages,frequence,logging)
fprintf(strcat('\n\n--->',pathToImages, '\n'));

files = dir(strcat(pathToImages,'*.jpg'));

fileIndex = find(~[files.isdir]);
    code='';

for imageIndex = 1:length(fileIndex)

    filename = files(fileIndex(imageIndex)).name;

    fprintf(strcat('\n\n--->',filename, '\n'));
    image = imread(strcat(pathToImages,filename));
    image = im2double(image);
    imFinal = image;

    rowToDelete=10;
    frames={50};
    tic();

    
    for deleted=1:rowToDelete
        fprintf('\n---> Deleting row %d of %d',deleted,rowToDelete);
        imGif=imFinal;
        [energy,Ix,Iy] = calculateEnergy(imFinal);
        frameCount=size(frames,2);
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
            
            imGif=colorPixelForGif(imGif,minEnergyPixelRow,minEnergyPixelColumn);
            frameIndex=frameCount+pixelLine;
            frames=addFrameByFrequence(frames,imGif,frequence,frameIndex,logging);

            imFinal = shiftPixelRight(imFinal,minEnergyPixelRow,minEnergyPixelColumn,false);

            startCol=minEnergyPixelColumn-1;
            stopCol=minEnergyPixelColumn+1;

        end
        imFinal(:,1,:)=[];
        frames=addFrame(frames,imFinal,logging);
    end

    createAnimatedGif(filename,0,frames,logging);
    toc();

    %figure(imageIndex);
    %subplot_tight(1,2,1), imshow(imageGray); title('Originale');
    %subplot_tight(1,2,2), imshow(imFinal); title('Modifi�e');


end
