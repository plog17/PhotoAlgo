function [ angles ] = getAngles( im )
%%    
    [energy,Ix,Iy] = calculateEnergy(im);
    angles=radtodeg(sin(Ix./Iy));
    angles(isnan(angles(:)))=45;
        
end

