function [ match1,match2 ] = matchDescriptors(im1pts, im1desc, im2pts, im2desc)
%MATCHES Matches points from pts1 to pts2 using respective descriptors
% Expects descriptors from descriptors function (matrix form)
% Uses square between 2 vectors. If 1NN/2NN <=.6

distances=dist2(im1desc,im2desc); %(i,j) is ith of pts1 and jth of pts2

[nn1, ind]=min(distances); %min of each column and their locations

% replaces all min values with a really big number
distances(sub2ind(size(distances),ind,[1:size(im1pts,1)])) = 500; %arbitrary big number

nn2=min(distances);

ratio = nn1./nn2;

matchPairs=[[1:size(im1pts,1)] ; ind ; ratio];

badMatches = (matchPairs(3,:)>.6);
matchPairs(:,badMatches)=[];

match1=im1pts(matchPairs(2,:),:);
match2=im2pts(matchPairs(1,:),:);

end

