clear;
path='../web/images/orig/';
angle=35;
strokeLength=10;
strokeWidth=5;
brush=[-1 0 0 0 1];
%brush=repmat(brushPart,[10 1]);
files = dir(strcat(path,'*.jpg'));
fileIndex = find(~[files.isdir]);

%%
for i = 1:length(fileIndex)
    %%
    filename = files(fileIndex(i)).name;
    im=getImageFromPath(strcat(path,filename));
    filename = strrep(filename,'.jpg','');
    
    % Get intensity image
    imG=rgb2gray(im);

    % Filter
    fs=7;
    filter=[fs fs];
    G = fspecial('gaussian',filter,2);
    imF = imfilter(imG,G,'same');

    % Filtrer
    imE = edge(imF,'canny');

    %imE = edge(imF,'sobel');
    %fonction energie tp2
    %imE=calculateEnergy(imF);

    [height, width]=size(imE);
    [meshxs, meshys]=meshgrid(1:width,1:height);

    % Peinturons!
    %[out,painted]=paint(im,imE,angle,strokeLength,strokeWidth,meshxs,meshys);
    %imwrite(out,strcat(filename,'_base.jpg'));
    
    %[out,painted]=paintRandom(im,imE,angle,strokeLength,strokeWidth,meshxs,meshys);
    %imwrite(out,strcat(filename,'_random.jpg'));
    
    %[out,painted]=paintRandomAutoAngle(im,imE,strokeLength,strokeWidth,meshxs,meshys);
    %imwrite(out,strcat(filename,'_angle.jpg'));
    
    [out,painted]=paintRandomAutoAngleGradient(im,imE,strokeLength,strokeWidth,meshxs,meshys,brush);
    %imwrite(out,strcat(filename,'_gradient.jpg'));
   

    imwrite(out,strcat(filename,'_it1_canny.jpg'));
    %imwrite(painted,strcat('painted_',filename,'_45Grad2.jpg'));
end


%%
subplot(1,2,1), imshow(save1);
subplot(1,2,2), imshow(out);


%% Final
imshow(final);
imwrite(final,'final.jpg');