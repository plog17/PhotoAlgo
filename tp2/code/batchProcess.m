function batchProcess(pathToImages) 
fprintf(strcat('\n\n--->',pathToImages, '\n'));

files = dir(strcat(pathToImages,'*.jpg'));
    
fileIndex = find(~[files.isdir]);
    code='';

for imageIndex = 1:length(fileIndex)
    tic();
    filename = files(fileIndex(imageIndex)).name;
    
    fprintf(strcat('\n\n--->',filename, '\n'));
    image = imread(strcat(pathToImages,filename));
    image = im2double(image);
    imageGray = rgb2gray(image);
    imFinal = imageGray;
    
        
    [Ix, Iy] = gradient(imageGray); % first order partials
    energy = Ix + Iy;
        
    for pixelLine = 1: size(energy,1)    
        minEnergyOnLine=[0,0];
        minEnergy=Inf;
        for pixelColumn = 1: size(energy,2)
           if Ix(pixelLine,pixelColumn)<minEnergy
            minEnergy = Ix(pixelLine,pixelColumn);
            minEnergyOnLine = [pixelLine,pixelColumn];
           end
        end
        
        imFinal(minEnergyOnLine(1,1),minEnergyOnLine(1,2))=0;
                
    end

    figure(imageIndex);
    subplot_tight(1,2,1), imshow(imageGray); title('Originale');
    subplot_tight(1,2,2), imshow(imFinal); title('Modifiée');

   
end
