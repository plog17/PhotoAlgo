function batchProcessQ2_opt(pathToImages)

    files = dir(strcat(pathToImages,'*.jpg'));
    fileIndex = find(~[files.isdir]);

for i = 1:length(fileIndex)
    %try
      filename = files(fileIndex(i)).name;
      tic();
      fprintf(strcat('\n\n--->',filename, '\n'));
      im1 = imread(strcat(pathToImages,filename));
      im1 = im2double(im1);

      fprintf('--->Splitting RGB\n');
      height = floor(size(im1,1)/3);
      B = im1(1:height,:);
      G = im1(height+1:height*2,:);
      R = im1(height*2+1:height*3,:);
     
      fprintf('--->Cropping RGB\n');
      B = cropImage(B);
      G = cropImage(G);
      R = cropImage(R);

      fprintf('--->Aligning RGB\n');
      [movedG,gxoffset,gyoffset]  = getAlignedImageMultipleScales(B,G,5);
      [movedR,rxoffset,ryoffset]  = getAlignedImageMultipleScales(B,R,5);

      fprintf('--->Preparing color picture\n');
      RGB3 = cat(3,movedR,movedG,B);
      RGB3 = finalCropImage(RGB3);
      RGB3_eq = greyWorld(RGB3);
      RGB3_ad = histoEqualizer(RGB3_eq);
      
      figure(i);
      subplot_tight(1,2,1), imshow(RGB3); title('Image équilibrée');
      subplot_tight(1,2,2), imshow(RGB3_ad); title('Image ajustée');
      linkaxes;
      
      fprintf('--->Saving picture\n');
      filenameComplete=strrep(strcat('q2_aligned_',filename),'.tif','.jpg');
      imwrite(RGB3_ad,filenameComplete);

      %code = strcat(code,generateHtmlCode(filename,rxoffset,ryoffset,gxoffset,gyoffset));

      toc();
end


