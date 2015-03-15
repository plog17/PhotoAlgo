addpath('InPolygon-MEX/');
fps=15;
duration=2;
save = false;
pathToTxtFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.txt';
pathToImageFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.png';
pathToTxtSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.txt';
pathToImageSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.png';
filename='06To07';



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
triplot(tri,ptsInt(:,1),ptsInt(:,2));


%% Morph iteration
increment=1/(fps*duration);
frames{fps*duration}=[];
index=1;
for it=0:increment:1    
    fprintf('\nGenerating frame with warp and dissolve at %d',it);
    warp_frac=it;
    dissolve_frac=it;
    imf=morph(image1,image2,pts1,pts2,warp_frac,dissolve_frac);
    
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





%mesh=meshgrid(X1,Y1);
%Vq = interp2(mesh);

%loop for every triangle in triangulation
for it=1:size(tri,1)   
    x=[0:size(image1,1)]';
    y=[0:size(image1,2)]';
    xs = [X1(tri(it,1));X1(tri(it,2));X1(tri(it,3))];
   	ys = [Y1(tri(it,1));Y1(tri(it,2));Y1(tri(it,3))];
    itTri1 = [xs ys];
    xs = [X2(tri(it,1));X2(tri(it,2));X2(tri(it,3))];
   	ys = [Y2(tri(it,1));Y2(tri(it,2));Y2(tri(it,3))];
    itTri2 = [xs ys];
    %find which triangle the pixels belongs to
    %[IN] = mytsearch(Xint,Yint,tri,xs,ys);
    %findedTrit = [Xint(IN(1)),Yint(IN(1));Xint(IN(2)),Yint(IN(2));Xint(IN(3)),Yint(IN(3))];
    %findedTri1 = [X1(IN(1)),Y1(IN(1));X1(IN(2)),Y1(IN(2));X1(IN(3)),Y1(IN(3))];
    %findedTri2 = [X2(IN(1)),Y2(IN(1));X2(IN(2)),Y2(IN(2));X2(IN(3)),Y2(IN(3))];

    intermediate = getIntermediateTriangle(itTri1,itTri2);
    T1 = getTransformationMatrix(itTri1,intermediate);
    T2 = getTransformationMatrix(intermediate,itTri2);
    
    [xInTriangle,yInTriangle]=pointsInTriangle(findedTri1,image1);
    
    %calculate TX=positionAfterTransformation
    unos=(1:size(xInTriangle,1));
    X = vertcat(xInTriangle',yInTriangle',unos);
    positionAfterTransformation = T1*X;    

    %display tests
    imagec = drawTriangleInImage(itTri1,image1);
    imagec = drawTriangleInImage(itTri2,imagec);
    imagec = drawTriangleInImage(intermediate,imagec);
    
    
  %[INt,ON,IN_strict] = InPolygon(x,y,xs,ys);
end




%Interpolate
%Vq = interp2(X,Y

%%Calculate de morphed image
%morphed_img = morph(img1, img2, img1_pts, img2_pts, tri, warp_frac, dissolve_frac);