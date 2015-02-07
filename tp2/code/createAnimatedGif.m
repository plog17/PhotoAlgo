function createAnimatedGif(outputName,delayTime,frames,logging)

for i = 1:size(frames,2)
    if logging
        fprintf('\ncreating frame %d',i);
    end
    
    im=frames{i};
    im=imresize(im,.65);
    %im=im2uint8(im);
    [imind,cm] = rgb2ind(im,256);
    
    if i==1
        imwrite(imind,cm,strrep(outputName,'jpg','gif'),'gif','DelayTime',delayTime,'loopcount',inf);
    else
        imwrite(imind,cm,strrep(outputName,'jpg','gif'),'gif','DelayTime',delayTime,'writemode','append');
    end
end
  
end

