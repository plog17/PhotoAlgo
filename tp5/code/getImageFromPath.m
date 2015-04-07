function [ images_array, images_exposure ] = getImageFromPath( path )
    images = dir(strcat(path,'*.jpg'));
    imagesIndex = find(~[images.isdir]);
    images_array{size(images,1)}=[];
    images_exposure{size(images,1)}=[];

    for imageIndex = 1:length(imagesIndex)
        images_array{imageIndex}=im2double(imread(strcat(path,images(imagesIndex(imageIndex)).name)));
        infos=imfinfo(strcat(path,images(imagesIndex(imageIndex)).name));
        exposure=infos.DigitalCamera.ExposureTime;
        images_exposure{imageIndex}=exposure;
    end
end

