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
    imGif=image;

    [energy,Ix,Iy] = calculateEnergy(image);
    frames={size(energy,1)};
    
    rowToDelete=1;
    startCol=1;
    stopCol=size(energy,2);
    
    tic();

    for deleted=1:rowToDelete
        fprintf('\n------> DELETED: %d',deleted);
        for pixelLine = 1: size(energy,1)-1
            minEnergyOnLine=[1,1];
            minEnergy=Inf;
            for pixelColumn = startCol: stopCol
               if Ix(pixelLine,pixelColumn)<minEnergy
                minEnergy = Ix(pixelLine,pixelColumn);
                minEnergyOnLine = [pixelLine,pixelColumn];
               end
            end

            imGif(minEnergyOnLine(1,1),minEnergyOnLine(1,2),1)=255;
            imGif(minEnergyOnLine(1,1),minEnergyOnLine(1,2),2)=0;
            imGif(minEnergyOnLine(1,1),minEnergyOnLine(1,2),3)=0;
            frames=addFrameByFrequence(frames,imGif,frequence,pixelLine,logging);

            imFinal = shiftPixelRight(imFinal,minEnergyOnLine(1,1),minEnergyOnLine(1,2),logging);

            startCol=minEnergyOnLine(1,2)-1;
            stopCol=minEnergyOnLine(1,2)+1;

        end
        imFinal(:,1,:)=[];
        frames=addFrameByFrequence(frames,imFinal,frequence,pixelLine,logging);
    end

    createAnimatedGif(filename,0,frames,logging);
    toc();

    %figure(imageIndex);
    %subplot_tight(1,2,1), imshow(imageGray); title('Originale');
    %subplot_tight(1,2,2), imshow(imFinal); title('Modifi�e');


end
