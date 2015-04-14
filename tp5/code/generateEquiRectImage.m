function [ latlon ] = generateEquiRectImage( im )

%% Transormation panoramique
[phis, thetas] = meshgrid([pi:pi/360:2*pi 0:pi/360:pi], pi/2:-pi/360:-pi/2);

%pour obtenir l
angles=[phis(:),thetas(:)];

%l en cartésien 
%on pose r=1
r=1;
[z,x,y]=sph2cart(angles(:,1),angles(:,2),r);
l=[x(:),y(:),z(:)];

%pour obtenir N, on calcul avec R = V - 2 .* dot(V,N) .* N
V=[0 0 1];

R=l;
for it=1:size(l,1)
    %N(it,:) = V - 2 .* dot(V,l(it,:)) .* l(it,:);
    
    syms N;
    solve((V(1)*N(it,1)+V(2)*N(it,2)+V(1)*N(it,2)) * N(it,:) - ((R/V)/2)==0,N);
    
    solve(R(it,:)==V-2.*dot(V,N).*N,N)
    
    for j=1:3
        (R-V)/2 = V(j,:)*N( .* N;
    end
end


%on retrouve x,y
[xs,ys] = meshgrid(linspace(-1,1,size(im,2)), linspace(-1,1,size(im,1))); 

latlon = repmat(zeros(size(phis)), [1 1 3]); 
for c=1:3
    latlon(:,:,c)=reshape(interp2(xs,ys,im(:,:,c),N(:,1),N(:,2)),size(latlon,1),size(latlon,2));
end


end

