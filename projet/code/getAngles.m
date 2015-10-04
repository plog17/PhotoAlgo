function [ angles ] = getAngles( im )
%%    
    [energy,Ix,Iy] = calculateEnergy(im);
    %angles=radtodeg(sin(Iy./Ix));
    angles=radtodeg(atan(Ix./Iy));
    angles(isnan(angles(:)))=45;
    angles(angles(:)==0)=1;
    angles(angles(:)==180)=1;    
end

