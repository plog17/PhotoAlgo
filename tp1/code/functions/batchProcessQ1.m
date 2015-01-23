function batchProcessQ1(pathToImages)

    files = dir(strcat(pathToImages,'*.tif'));
    fileIndex = find(~[files.isdir]);
    code='';

for i = 1:length(fileIndex)
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

      %saveRBG(filename,R,G,B);

      fprintf('--->Aligning RGB\n');
      [movedG,gxoffset,gyoffset]  = getAlignedImage(B,G);
      [movedR,rxoffset,ryoffset]  = getAlignedImage(B,R);

      movedR = circshift(R,[rxoffset ryoffset]);
      movedG = circshift(R,[gyoffset gyoffset]);
      
      fprintf('--->Preparing color picture\n');
      RGB3 = cat(3,movedR,movedG,B);

      fprintf('--->Saving picture\n');
      filenameComplete=strrep(strcat('q1_aligned_',filename),'.tif','.jpg');
      imwrite(RGB3,filenameComplete);

      code = strcat(code,generateHtmlCode(filename,rxoffset,ryoffset,gxoffset,gyoffset));

      toc();
end
code
