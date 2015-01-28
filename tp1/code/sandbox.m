
fprintf('-------Reading picture file-------\n');
pathtoimage='/Users/plauger/Pictures/Photographie Algorithmique/TP1/images/tocrop/';
files = dir(strcat(pathtoimage,'*.jpg'));
fileIndex = find(~[files.isdir]);
addpath('functions');

for i = 1:length(fileIndex)
    %try
      filename = files(fileIndex(i)).name;
      tic();
      fprintf(strcat('\n\n--->',filename, '\n'));
      im1 = imread(strcat(pathtoimage,filename));
      im1 = im2double(im1);

      RGB3_eq = finalCropImage(im1);
      
      subplot_tight(1,2,1), imshow(im1); title('Image originale');
      subplot_tight(1,2,2), imshow(RGB3_eq); title('Image équilibrée');
      
      fprintf('--->Saving picture\n');
      filenameComplete=strrep(strcat('',filename),'.tif','.jpg');
      imwrite(RGB3_eq,filenameComplete);


end


