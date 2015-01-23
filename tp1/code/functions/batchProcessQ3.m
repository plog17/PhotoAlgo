function batchProcessQ3(pathToImages, pictureName)
    tic();    
    code='';

    fprintf(strcat('\n\n--->',pictureName, '\n'));
    R = imread(strcat(pathToImages,pictureName,'_1.jpg'));
    R = im2double(R);
    G = imread(strcat(pathToImages,pictureName,'_2.jpg'));
    G = im2double(G);
    B = imread(strcat(pathToImages,pictureName,'_3.jpg'));
    B = im2double(B);

    fprintf('--->Splitting RGB\n');
    R(:,:,2:3)=0;
    G(:,:,1)=0;
    G(:,:,2)=0;
    B(:,:,1:2)=0;

    %fprintf('--->Cropping RGB\n');
    %B = cropImage(B);
    %G = cropImage(G);
    %R = cropImage(R);

    fprintf('--->Aligning RGB\n');
    [movedG,gxoffset,gyoffset]  = getAlignedImageMultipleScales(B,G,5);
    [movedR,rxoffset,ryoffset]  = getAlignedImageMultipleScales(B,R,5);

    fprintf('--->Preparing color picture\n');
    RGB3 = cat(3,movedR,movedG,B);

    %RGB3 = RGB3(1:size(RGB3,1)-10,:);

    fprintf('--->Saving picture\n');
    filenameComplete=strcat('perso_aligned_',pictureName,'.jpg');
    imwrite(RGB3,filenameComplete);

    code = strcat(code,generateHtmlCode(filename,rxoffset,ryoffset,gxoffset,gyoffset))

    toc();
end
