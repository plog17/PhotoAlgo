function [output] = addFrameByFrequence(frames,frame,frequence,it,logging)
    output=frames;
    if mod(it,frequence)==0
        if logging
            fprintf('\nAdding frame %it',it);
        end
        output=addFrame(frames,frame,logging);
    end
end

