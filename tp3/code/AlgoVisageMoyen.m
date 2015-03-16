function AlgoVisageMoyen(pathToImages)
    images = dir(strcat(pathToImages,'*.png'));
    imagesIndex = find(~[images.isdir]);
    coords = dir(strcat(pathToImages,'*.txt'));
    coordsIndex = find(~[coords.isdir]);

    images_array{size(images,1)}=[];
    coords_array{size(images,1)}=[];

    for imageIndex = 1:length(imagesIndex)
        filename = images(imagesIndex(imageIndex)).name;
        images_array{imageIndex}=im2double(imread(strcat(pathToImages,filename)));
    end

    for coordIndex = 1:length(coordsIndex)
        filename = coords(coordsIndex(coordIndex)).name;
        currentCoords = readTxtFile(strcat(pathToImages,filename));

        if coordIndex==1
            sum = currentCoords;
        else
            sum = sum + currentCoords;
        end

        coords_array{coordIndex}=currentCoords; 
    end

    averagePts = sum/coordIndex;
    
    % Add points to corners and middle left-right
    [height,width,channels] = size(images_array{1});  
    averagePts = [averagePts; 1,1; 1,height; width,1; width,height;1,height/2;width,height/2];

    % Compute triangulation with Delaunay on averagePts
    tri = delaunay(averagePts(:,1),averagePts(:,2));

    for it=1:size(images_array,2)

        % Read images points
        image1 = images_array{it};
        pts1 = [];
        pts1 = coords_array{it};

        % Add points to corners and middle left-right 
        pts1 = [pts1; 1,1; 1,height; width,1; width,height;1,height/2;width,height/2];

        warp_frac=.5;
        dissolve_frac=0;
        imf=morph(image1,image1,pts1,averagePts,tri,warp_frac,dissolve_frac);

        %imshow(imf);

        if it==1
            imSum = imf/size(images_array,2);
        else
            imSum = imf/size(images_array,2)+imSum;
        end

    end 
    imshow(imSum);
end

