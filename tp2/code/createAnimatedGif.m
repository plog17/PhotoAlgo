function createAnimatedGif(outputName,delayTime,frames)
imwrite(frames{1},strrep(outputName,'jpg','gif'),'gif','writemode','overwrite','LoopCount',inf,'DelayTime',delayTime);

for i = 2:10    %size(frames,2)
    %imwrite(frames{i},strcat(strrep(outputName,'.jpg',''),i,'.jpg'));
    imwrite(frames{i},strrep(outputName,'jpg','gif'),'gif','writemode','append','DelayTime',delayTime)
end
    
end

