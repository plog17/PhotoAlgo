function [ images_array, images_logExposure ] = getImageFromPath( path )
    images = dir(strcat(path,'*.jpg'));
    imagesIndex = find(~[images.isdir]);
    images_array{size(images,1)}=[];
    images_logExposure{size(images,1)}=[];

    for imageIndex = 1:length(imagesIndex)
        images_array{imageIndex}=im2double(imread(strcat(path,images(imagesIndex(imageIndex)).name)))*1000;
        infos=imfinfo(strcat(path,images(imagesIndex(imageIndex)).name));
        logExposure=log(infos.DigitalCamera.ExposureTime);
        images_logExposure{imageIndex}=logExposure;
    end
end

