function saveAndDisplayFeatures(imgfilename,n)
% Merci à Louis Bourdages pour cette version!

if(nargin<2)
    n=43;
end

img = imread(imgfilename);
figure;imshow(img);
hold on;

xy = [];
for i = 1:n
	[x,y] = ginput(1);
	plot(x,y,'.r', 'LineWidth',5);
	xy = [xy; x y];
end

asciifilename = [imgfilename(1:find(imgfilename=='.',1,'last')) 'txt'];
save(asciifilename, 'xy', '-ascii');