function createAnimatedGif(outputName,delayTime,frames)

for i = 1:size(frames,2)
    im=frames{i};
    [imind,cm] = rgb2ind(im,256);
    
    if i==1
        imwrite(imind,cm,strrep(outputName,'jpg','gif'),'gif','DelayTime',delayTime,'loopcount',inf);
    else
        imwrite(imind,cm,strrep(outputName,'jpg','gif'),'gif','DelayTime',delayTime,'writemode','append');
    end
end
  
end

