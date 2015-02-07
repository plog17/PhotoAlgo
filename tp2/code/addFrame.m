function [frames] = addFrame(frames,frame,logging)
    currentSize=size(frames,2);
    if size(frames{1},2)<2
        if logging
            fprintf('\nAdding 1st frame');
        end
        frames{1}=frame;
    else
        if logging
            fprintf('\nAdding frame at index %d',currentSize+1);
        end
        frames{currentSize+1}=frame;
    end
end

