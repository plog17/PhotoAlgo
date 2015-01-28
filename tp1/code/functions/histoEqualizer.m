function egalized = histoEqualizer(img)
%Tout le crédit va à l'hauteur original. 
%Ce code est issu de la démonstration faite au cours #2

% histogramme
imgHist = imhist(img);
% histogramme cumulatif
imgHistCum = cumsum(imgHist);

%figure(10);
%subplot(2,1,1), plot(h); title('Histogramme');
%subplot(2,1,2), plot(imgHistCum); title('Histogramme cumulatif');

N = size(img,1)*size(img,2);

egalized = uint8(imgHistCum(img+1)/N*255);