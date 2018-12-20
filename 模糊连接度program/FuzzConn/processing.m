function [g2] = processing(img)
se = strel('disk', 3);
g = imerode(img, se); %g为腐蚀图像
g1 = imopen(img, se);%g1为开运算
g2 = imclose(img,se);%g2闭运算
g3 = imopen(g2, se);%g3为闭开运算
g4 =  imdilate(img, se);%g4为膨胀运算


%subplot(1,2,1),imshow(img),title('原图');
%subplot(1,2,2),imshow(img_close), title('腐蚀图像');