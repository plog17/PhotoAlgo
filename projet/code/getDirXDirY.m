function [ dirx diry ] = getDirXDirY( angle )
    %only working with 45deg angle now
    factor=2;
    dirx=factor*cosd(angle)^2;
    diry=factor*sind(angle)^2;
end

