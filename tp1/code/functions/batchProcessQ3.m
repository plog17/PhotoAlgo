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
    R=R(:,:,1);
    G=G(:,:,2);
    B=B(:,:,3);

    %imwrite(R,strcat(pictureName,'_R.jpg'));
    %imwrite(G,strcat(pictureName,'_G.jpg'));
    %imwrite(B,strcat(pictureName,'_B.jpg'));

    fprintf('--->Aligning RGB\n');
    %[movedG,gxoffset,gyoffset]  = getAlignedImageMultipleScales(B,G,5);
    %[movedR,rxoffset,ryoffset]  = getAlignedImageMultipleScales(B,R,5);

    [movedG,gxoffset,gyoffset]  = getAlignedImage(B,G);
    [movedR,rxoffset,ryoffset]  = getAlignedImage(B,R);
    
    fprintf('\nOffset green (%d,%d)',gxoffset,gyoffset);
    fprintf('\nOffset red (%d,%d)',rxoffset,ryoffset);
    
    fprintf('--->Preparing color picture\n');
    RGB3 = cat(3,movedR,movedG,B);

    fprintf('--->Saving picture\n');
    filenameComplete=strcat('perso_aligned_',pictureName,'.jpg');
    imwrite(RGB3,filenameComplete);

    %code = strcat(code,generateHtmlCode(filenameComplete,rxoffset,ryoffset,gxoffset,gyoffset))

    toc();
end
