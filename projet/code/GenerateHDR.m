function [im]=GenerateHDR(path,filename)

l=1;
srow=30;
scol=30;
channels=3;

%% Carte de radiance

fprintf('\n---Chargement images et vitesses d''obturation\n');
[Z,B]=getImageFromPath(path);

fprintf('---Resize images pour calculs plus rapides\n');
Zresized = zeros(srow, scol, channels, size(Z,4));

for i = 1:size(Z,4)
    Zresized(:,:,:,i) = round(imresize(Z(:,:,:,i), [srow scol], 'bilinear'));
end

fprintf('---gsolve\n');
w=ponderationFunction();

for channel = 1:3
    ZresizedRepshaped = reshape(Zresized(:,:,channel,:), srow*scol, size(Z,4));
    [logExposure(:,channel), logRadiance(:,channel)] = gsolve(ZresizedRepshaped, B, l, w);
end

fprintf('---Construire HDR\n');
im=assembleHDR(Z,logExposure,B,w);

%im=reinhardAndAl(imHDR);
%fprintf('---Ajuster contraste\n');
%imEqR=histeq(im(:,:,1));
%imEqG=histeq(im(:,:,2));
%imEqB=histeq(im(:,:,3));
%imEq=cat(3,imEqR,imEqG,imEqB);
%imshow(imEq);

fprintf('---Sauvegarder l''image\n');
imshow(im);
hdrwrite(im,strcat(filename,'.hdr'));

end

