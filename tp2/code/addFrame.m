function [frames] = addFrame(frames,frame)
    frames{size(frames,2)+1}=frame;
end

