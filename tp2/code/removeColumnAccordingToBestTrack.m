function [image,imGif ] = removeColumnAccordingToBestTrack( startFromColumn, tracks, image )
    nbRow=size(image,1);
    imGif=image;
    currentFromColumn=startFromColumn;

    %on remonte le tableau a partir d'en bas
    for row=nbRow:-1:2
        if row==nbRow
            imGif=colorPixelForGif(imGif,row,startFromColumn);      
            image=shiftPixelRight(image,row,startFromColumn,false);
        else
            imGif=colorPixelForGif(imGif,row,tracks(row,currentFromColumn));                  
            image=shiftPixelRight(image,row,tracks(row,currentFromColumn),false);
        end
        currentFromColumn=tracks(row,currentFromColumn);
    end
end

