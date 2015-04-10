function [ imHDR ] = assembleHDR( Z,g,B,w )
    [row, col, channels, frames] = size(Z);
    logRadiance = zeros(row, col, 3);
    
    for currentChannel = 1:channels
        for x = 1:row
            for y = 1:col
                totalLogExposure = 0;
                totalWeight = 0;
                for currentFrame = 1:frames
                    lZ = Z(x, y, currentChannel, currentFrame) + 1;
                    lw = w(lZ);
                    lg = g(lZ);
                    lB = B(currentFrame);

                    totalLogExposure = totalLogExposure + lw * (lg - lB);
                    totalWeight = totalWeight + lw;
                end
                logRadiance(x, y, currentChannel) = totalLogExposure / totalWeight;
            end
        end
    end
    
    %Notez que cela produit les valeurs log de la radiance, 
    %donc assurez-vous de faire l'exponentielle du résultat et de sauvegarder la radiance absolue.
    imHDR = exp(logRadiance);
    
    index = find(isnan(imHDR) | isinf(imHDR));
    imHDR(index) = 0;
end

