im=imread('house_by_jim_mccann.jpg');
im=im2double(im);



imRotate=imrotate(im,90);
cost=energy;
tracks=energy;


BW = roipoly(im)

tic();
energy=calculateEnergy(sim);
toc();

tic();
[imFinal,imGif]=removeColumnAccordingToBestTrack(startFromColumn,tracks,im);
toc();