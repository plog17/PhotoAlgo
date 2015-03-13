function [ X,Y ] = pointsInTriangle( tri,image )
%http://www.mathworks.com/matlabcentral/newsreader/view_thread/170977

x = [1:size(image,1)]';
y(1:size(image,2))=1;
xs= x;
ys=y';
for it=2:size(image,1)
    xs = cat(1,xs,x);
    y(1:size(image,2))=it;
    ys = cat(1,ys,y');
end

x1=tri(1,1);
y1=tri(1,2);
x2=tri(2,1);
y2=tri(2,2);
x3=tri(3,1);
y3=tri(3,2);

% Set up nine coefficients
 s = sign(x1*y2-y1*x2+x2*y3-y2*x3+x3*y1-y3*x1);
 c12 = s*(y1-y2); c23 = s*(y2-y3); c31 = s*(y3-y1);
 d12 = s*(x1-x2); d23 = s*(x2-x3); d31 = s*(x3-x1);
 e12 = s*(x1*y2-y1*x2); 
 e23 = s*(x2*y3-y2*x3); 
 e31 = s*(x3*y1-y3*x1);

 % Then check (x,y) vectors for being inside triangle
 t = (c12*xs-d12*ys+e12>=0) & ...
     (c23*xs-d23*ys+e23>=0) & ...
     (c31*xs-d31*ys+e31>=0);
 X = xs(t); 
 Y = ys(t);
end

