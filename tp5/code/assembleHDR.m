function [ imHDR ] = assembleHDR( Z,g,B,w )
    [row, col, channels, frames] = size(images);
    
    for currentChannel = 1:channels
	for y = 1:row
	    for x = 1:col
		total_lnE = 0;
		totalWeight = 0;
		for j = 1:frames
		    tempZ = images(y, x, currentChannel, j) + 1;
		    tempw = w(tempZ);
		    tempg = g(tempZ);
		    templn_t = ln_t(j);

		    total_lnE = total_lnE + tempw * (tempg - templn_t);
		    totalWeight = totalWeight + tempw;
		end
		ln_E(y, x, currentChannel) = total_lnE / totalWeight;
	    end
	end
    end
    imgHDR = exp(ln_E);

    % remove NAN or INF
    index = find(isnan(imgHDR) | isinf(imgHDR));
    imgHDR(index) = 0;
end

