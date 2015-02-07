function [output] = addFrameByFrequence(frames,frame,frequence,it,logging)
    output=frames;
    if mod(it,frequence)==0
        output=addFrame(frames,frame,logging);
    end
end

