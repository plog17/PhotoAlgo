img1 = imread('am.png');
img2 = imread('pm.png');

t = linspace(0, 1, 50);

figure(1); clf;
subplot 221, imshow(img1);
subplot 222, imshow(img2);

subplot(2,2,[3 4]);
h = imshow(img1);

for i_t = 1:length(t)
    img = img2*t(i_t) + img1*(1-t(i_t));
    
    set(h, 'CData', img);
    pause(0.25);
end

