function [ imHDR ] = assembleHDR( Z,g,B,w )
    [row, col, channels, frames] = size(Z);
    logRadiance = zeros(row, col, 3);
    
    for currentChannel = 1:channels
        for x = 1:col
            for y = 1:row
                totalLogExposure = 0;
                totalWeight = 0;
                for currentFrame = 1:frames
                    lZ = Z(y, x, currentChannel, currentFrame) + 1;
                    lw = w(lZ);
                    lg = g(lZ);
                    lB = B(currentFrame);

                    totalLogExposure = totalLogExposure + lw * exp(lg - lB);
                    totalWeight = totalWeight + lw;
                end
                logRadiance(y, x, currentChannel) = totalLogExposure / totalWeight;
            end
        end
    end
    
    %Notez que cela produit les valeurs log de la radiance, 
    %donc assurez-vous de faire l'exponentielle du résultat et de sauvegarder la radiance absolue.
    imHDR = (logRadiance);
    
    %enlever pixels invalides
    index = find(isnan(imHDR) | isinf(imHDR));
    imHDR(index) = 0;
end

