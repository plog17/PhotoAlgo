function saveRBG(filename,R,G,B)

imwrite(B,strcat('../web/pictures/',filename'_B.jpg'));
imwrite(G,strcat('../web/pictures/',filename'_G.jpg'));
imwrite(R,strcat('../web/pictures/',filename'_R.jpg'));
