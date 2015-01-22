function cropedImage = cropImage(image)
details = getCropDetails(image);
cropedImage = imcrop(image, details);
