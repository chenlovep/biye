function [img_imerode] = processing(img)
figure;
title('Ô­Í¼');
imshow(img);
se = strel('disk', 10);
img_imerode = imclose(img,se);
subplot(1,2,1),imshow(img),title('Ô­Í¼');
subplot(1,2,2),imshow(img_imerode), title('¸¯Ê´Í¼Ïñ');