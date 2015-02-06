function batchProcess(pathToImages)
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
    rowToDelete=10;

    startCol=1;
    stopCol=size(energy,2);
    tic();

    for deleted=1:rowToDelete
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
        frames=addFrame(frames,imGif);

        imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2),1)=imGif(minEnergyOnLine(1,1)+1,minEnergyOnLine(1,2)+1,1);
        imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2),2)=imGif(minEnergyOnLine(1,1)+1,minEnergyOnLine(1,2)+1,2);
        imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2),3)=imGif(minEnergyOnLine(1,1)+1,minEnergyOnLine(1,2)+1,3);

        %imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2),3)=[];
        %imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2),2)=[];
        %imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2),1)=[];


        startCol=minEnergyOnLine(1,2)-1;

        stopCol=minEnergyOnLine(1,2)+1;

    end
        imFinal(:,1)=[];
        frames=addFrame(frames,imFinal);
    end


    createAnimatedGif(filename,0,frames);
    toc();

    %figure(imageIndex);
    %subplot_tight(1,2,1), imshow(imageGray); title('Originale');
    %subplot_tight(1,2,2), imshow(imFinal); title('Modifi�e');


end
