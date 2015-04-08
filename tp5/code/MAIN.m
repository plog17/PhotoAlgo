path='/Users/plauger/git/PhotoAlgo/tp5/web/images/origin/alignees/corridor/';
numPixels=250;
l=1;
srow=10;
scol=20;
channels=3;
reducedFactor=1/10;

addpath('tests/program/')

fprintf('\n---Chargement images et vitesses d''obturation\n');
[Z,B]=getImageFromPath(path);

fprintf('---Resize images pour calculs plus rapides\n');
Zresized = zeros(srow, scol, channels, size(Z,4));
for i = 1:size(Z,4)
    Zresized(:,:,:,i) = round(imresize(Z(:,:,:,i), [srow scol], 'bilinear'));
end


fprintf('---gsolve\n');
w=ponderationFunction();
w=w/max(w);

for channel = 1:3
    ZresizedRepshaped = reshape(Zresized(:,:,channel,:), srow*scol, size(Z,4));
    [g(:,channel), lnE(:,channel)] = gsolve(ZresizedRepshaped, B, l, w);
end



