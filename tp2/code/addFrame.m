function [frames] = addFrame(frames,frame,logging)
    currentSize=size(frames,2);
    if size(frames{1},2)<2
        frames{1}=frame;
    else
        frames{currentSize+1}=frame;
    end
end

