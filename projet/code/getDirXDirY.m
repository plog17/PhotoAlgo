function [ dirx diry ] = getDirXDirY( angle )
    absangle=abs(angle);
    
    if absangle > 45
        dirx=1;
        diry=0;
    elseif absangle < 15
        dirx=0;
        diry=1;
    else
        dirx=1;
        diry=1;
    end
       
    if angle<0
        diry=diry*-1;
    end
end

