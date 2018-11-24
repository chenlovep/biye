pt='date/';
save='FCM_color/';
subdir=dir(pt);
count=1;
for k=1:length(subdir)
    subdirpath=fullfile(pt,subdir(k).name,'*.jpg');
    images=dir(subdirpath);
    for j=1:length(images)
        ImageName=fullfile(pt,subdir(k).name,images(j).name);
        disp(ImageName)
        [color_picture]=segment(ImageName);
        savename=fullfile(save,images(j).name);
        imwrite(color_picture,savename);
    end
end

