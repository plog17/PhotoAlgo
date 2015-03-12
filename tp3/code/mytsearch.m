%mytsearch - search triangulation
% 
% by David R. Martin, Boston College
% [t] = mytsearch(x,y,tri,X,Y);
%
% x,y,tri is an unrestricted triangulation
% X,Y are the query points
% t(i) gives the index (into tri) of the first triangle containing (X(i),Y(i))
% t(i) is NaN for points not in any triangle
%
% Make sure you're using the mex version of this code; it's about 15x
% faster.

% The basis for this function is the observation that for a triangle
% (A,B,C) and a point p, the point is in the triangle if the z coordinates
% of cross(B-A,p-A) and cross(B-A,C-A) have the same sign, and similarly
% for the other two sides of the triangle.  We need only compute the z
% coordinate of the cross product, which for two vectors (a,b) and (c,d) is
% ac-bd.  