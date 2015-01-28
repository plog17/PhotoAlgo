function egalizedImage = greyWorld(image)
%Tout le crédit va à l'hauteur original. 
%Ce code est issu de la démonstration faite au cours #2

imgVec = reshape(image, size(image,1)*size(image,2), size(image,3));
moyenne = mean(imgVec, 1);
facteur = moyenne(2) ./ moyenne;
imgVec = imgVec.*repmat(facteur, size(imgVec,1), 1);
egalizedImage = reshape(imgVec, size(image,1), size(image,2), size(image,3));