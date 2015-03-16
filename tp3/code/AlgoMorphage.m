function AlgoMorphage()
fps=5;
duration=1;
pathToTxtFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.txt';
pathToImageFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.png';
pathToTxtSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.txt';
pathToImageSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.png';
filename=strcat('/out/06To07_',fps,'fps_',duration,'s.avi');


%% Read images points
image1 = im2double(imread(pathToImageFirst));
pts1 = readTxtFile(pathToTxtFirst);
image2 = im2double(imread(pathToImageSecond));
pts2 = readTxtFile(pathToTxtSecond);

%% Add points to corners and middle left-right
[height,width,hannels] = size(image1);  
pts1 = [pts1; 1,1; 1,height; width,1; width,height;1,height/2;width,height/2];
pts2 = [pts2; 1,1; 1,height; width,1; width,height;1,height/2;width,height/2];
ptsInt=pts1;

%% Compute average X and Y
for it=1:size(pts1,1)
   ptsInt(it,1) = (pts1(it,1)+pts2(it,1))/2;  
   ptsInt(it,2) = (pts1(it,2)+pts2(it,2))/2;  
end

%% Compute triangulation with Delaunay on the average X and Y
tri = delaunay(ptsInt(:,1),ptsInt(:,2));

%% Morph iteration
increment=1/(fps*duration);
frames{fps*duration}=[];
index=1;
for it=0:increment:1    
    fprintf('\nGenerating frame with warp and dissolve at %d',it);
    
    %set fracs
    warp_frac=it;
    dissolve_frac=it;
    
    %morph
    imf=morph(image1,image2,pts1,pts2,tri,warp_frac,dissolve_frac);
    
    %add frame
    frames{index}=imf; 
    index=index+1;
    
    imshow(imf);
end


%% Video setup
vw = VideoWriter([filename '.mp4']); 
vw.FrameRate = fps; % selection du nombre de trames par seconde du video 
open(vw);

for i=1:size(frames,2)-1
    writeVideo(vw,frames{i});
end
close(vw); %une fois toutes les images ajoutés au video





%%Calculate de morphed image
%morphed_img = morph(img1, img2, img1_pts, img2_pts, tri, warp_frac, dissolve_frac);
end

