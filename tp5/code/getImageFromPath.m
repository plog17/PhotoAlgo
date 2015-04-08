function [ Z, images_logExposure ] = getImageFromPath( path ) 
    images = dir(strcat(path,'*.jpg')); 
    imagesIndex = find(~[images.isdir]); 
    
    sampleImage=imread(strcat(path,images(imagesIndex(1)).name)); 
    
    Z=zeros(size(sampleImage,1),size(sampleImage,2),3,size(imagesIndex,2)); 
    images_logExposure=zeros(size(images,1),1); 
    
    for imageIndex = 1:length(imagesIndex) 
        Z(:,:,:,imageIndex)=imread(strcat(path,images(imageIndex).name)); 
        infos=imfinfo(strcat(path,images(imagesIndex(imageIndex)).name)); 
        logExposure=log(infos.DigitalCamera.ExposureTime); 
        images_logExposure(imageIndex,1)=logExposure; 
    end
end