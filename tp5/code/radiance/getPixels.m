function [ pixels ] = getPixels( image,n )
    pixels{n}=[];
    for i=1:n
      x = randi([1 size(image,1)]);
      y = randi([1 size(image,2)]);
      image(x,y) = rand(1)*255;
      
      pixels{i}=[x y];
    end

end

