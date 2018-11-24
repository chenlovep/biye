pt='date/';
save='k_means_color/';
img_path=dir(strcat(pt,'*.jpg'));
for j=1:length(img_path)
    image_name=img_path(j).name;
    Image_Name=strcat(pt,image_name);
    k=3;
    [mu,mask]=kmean(Image_Name,k);
    
    savename=fullfile(save,image_name);
    imwrite(mask,savename);
end

%{
subdir=dir(pt);
count=1;
for k=1:length(subdir)
    subdirpath=fullfile(pt,subdir(k).name,'*.jpg');
    images=dir(subdirpath);
    for j=1:length(images)
        %FCM-MRF
        ImageName=fullfile(pt,subdir(k).name,images(j).name);
        [color_picture]=segment(ImageName);
        savename=fullfile(save,images(j).name);
        imwrite(color_picture,savename);
    end
end
%}
