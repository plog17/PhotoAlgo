addpath('InPolygon-MEX/');

save = false;
pathToTxtFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.txt';
pathToImageFirst = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/06 - Pier-Luc.png';
pathToTxtSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.txt';
pathToImageSecond = '/Users/plauger/git/PhotoAlgo/tp3/code/pic/07 - SimonB.png';

image1 = im2double(imread(pathToImageFirst));
[ X1,Y1 ] = readTxtFile(pathToTxtFirst);
image2 = im2double(imread(pathToImageSecond));
[ X2,Y2 ] = readTxtFile(pathToTxtSecond);

%compute average X and Y
for it=1:size(X1,1)
   Xint(it) = (X1(it)+X2(it))/2;  
   Yint(it) = (Y1(it)+Y2(it))/2;  
end

%%Compute triangulation with Delaunay on the average X and Y
tri = delaunay(Xint,Yint);
figure(2);
triplot(tri,Xint,Yint);

%mesh=meshgrid(X1,Y1);
%Vq = interp2(mesh);


%loop for every triangle in triangulation
for it=1:size(tri,1)   
    tri1 = [X1(tri(it,1)),Y1(tri(it,1));X1(tri(it,2)),Y1(tri(it,2));X1(tri(it,3)),Y1(tri(it,3))];
    tri2 = [X2(tri(it,1)),Y1(tri(it,1));X2(tri(it,2)),Y1(tri(it,2));X2(tri(it,3)),Y1(tri(it,3))];

    x=[0:size(image1,1)]';
    y=[0:size(image1,2)]';
    xs = [X1(tri(it,1));X1(tri(it,2));X1(tri(it,3))];
   	ys = [Y1(tri(it,1));Y1(tri(it,2));Y1(tri(it,3))];
    %find which triangle the pixels belongs to
    [IN] = mytsearch(X1,Y1,tri,xs,ys);
   
    findedTri1 = [X1(IN(1)),Y1(IN(1));X1(IN(2)),Y1(IN(2));X1(IN(3)),Y1(IN(3))];

    %intermediate = getIntermediateTriangle(tri1,tri2);
    
    T1 = getTransformationMatrix(tri1,findedTri1);
    T2 = getTransformationMatrix(tri2,findedTri1);
    
    [xInTriangle,yInTriangle]=pointsInTriangle(findedTri1,image1);
    
    %calculate TX=Y
    unos = unos(1:size(xInTriangle,1));
    X = vertcat(xInTriangle',yInTriangle',unos);
 
    test = T1.*X;    
    
  %[INt,ON,IN_strict] = InPolygon(x,y,xs,ys);
end


%Interpolate
%Vq = interp2(X,Y

%%Calculate de morphed image
%morphed_img = morph(img1, img2, img1_pts, img2_pts, tri, warp_frac, dissolve_frac);

if save
    vw = VideoWriter([filename '.mp4']); 
    vw.FrameRate = 30; % selection du nombre de trames par seconde du video 
    open(vw); 
    % calculs!

    writeVideo(vw,img); %pour chaque trame (img) 
    close(vw); %une fois toutes les images ajoutés au video
end