function [ IMG ] = lashen( img )
%对图像进行拉伸处理，
%对图像进行图像增强
img_min=min(min(img));
img_max=max(max(img));
disp(img_min);disp(img_max);
[row,col]=size(img);
IMG=img*0;
for i=1:row
    for j=1:col
        IMG(i,j)=(img(i,j)-img_min)*img_max/(img_max-img_min);
    end
end
IMG=uint8(IMG);
end

