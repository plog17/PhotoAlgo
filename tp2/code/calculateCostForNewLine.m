function [ cost,tracks ] = calculateCostForNewLine(lineIndex,previousLine,energy,cost,tracks)   
lastElement=size(previousLine,2);
for currentPixel=1:lastElement
    left=0;
    right=0;
    if currentPixel==1
        left=1;
    else
        left=currentPixel-1;
    end
    
    if currentPixel==lastElement
        right=lastElement;
    else
        right=currentPixel+1;
    end
    
    
    minimalEnergy=energy(lineIndex,currentPixel)+cost(lineIndex-1,left);
    fromColumn=left;
    for i=left:right
        
        currentEnergy=energy(lineIndex,currentPixel)+cost(lineIndex-1,i);
        if currentEnergy<minimalEnergy
            minimalEnergy=currentEnergy;
            fromColumn=i;
        end
    end
    
    cost(lineIndex,currentPixel)=minimalEnergy;
    tracks(lineIndex,currentPixel)=fromColumn;
end

end

