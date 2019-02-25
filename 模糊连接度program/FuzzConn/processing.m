<<<<<<< HEAD
function [g] = processing(img,moshi)
%对图像进行预处理
%使用canny算子和直方图均衡算法进行相结合方法进行预处理
se = strel('disk', 3);
[r,c,channel] = size(img);
if channel == 3
    img_gray = rgb2gray(img);
else
    img_gray = img;
=======
function [img] = processing(IMG)

%对图像进行预处理
%方法1：采用形态学处理，原图像+（原图像-开运算）+（闭运算+原图像）
%{
se = strel('disk', 3);
[r,c] = size(img);
G = zeros(r,c);
for i = 1:r
    for j = 1:c
        if img(i,j)^2>255
            G(i,j)=255;
        else
            G(i,j) = img(i,j)^2;
        end
    end
>>>>>>> 4dc2d0eeda4c3529df8e9d401985df70dba992d2
end

% img_gray_ = double(img_gray);
% %拉普拉斯锐化处理
% w = fspecial('laplacian', 0);
% g1 = imfilter(img_gray, w, 'replicate');
% g = img-g1;
% 
% %将图像先阈值分割处理，将低部分进行去除
% thres = 30;
% while 1
%     T = zeros(r,c);
%     mean_1 = 0;
%     mean_2 = 0;
%     for i=1:r
%         for j=1:c
%             if img_gray_(i,j) >= thres
%                 mean_1 = mean_1 + img_gray_(i,j);
%                 T(i,j) = 1;
%             else
%                 mean_2 = mean_2 + img_gray_(i,j);
%             end
%         end
%     end
%     thres_1 = length(find(T == 1));
%     thres_2 = length(find(T == 0));
%     thres_1 = mean_1 / thres_1;
%     thres_2 = mean_2 / thres_2;
%     if abs(thres - (thres_1+thres_2)/2) < 1
%         break
%     end
%     thres = (thres_1+thres_2)/2;
% end
% 
% %canny边缘检测算法
% % canny_img = edge(img_gray, 'sobel',0.09);
% % for i =1 :r
% %     for j=1:c
% %         if canny_img(i,j) == 0
% %             canny_img(i,j) = 255;
% %         else
% %             canny_img(i,j) = 0;
% %         end
% %     end
% % end
% %直方图均衡算法
% 
% 
% 
% J=histeq(img_gray);  %直方图均衡化
% 
% J = J.*uint8(T);
% k1 = 0.5;
% A = k1*g + (1-k1)*J;
% figure;
% imshow(A);
% title('融合laplacian和直方图均衡');
% 
% I = find(T == 1);
% 
% I_img = img_gray(I);
% t = thres+30;
% while 1
%     thres_1 = [];
%     thres_2 = [];
%     for i=1:length(I_img)
%         if I_img(i) < t
%             thres_1 = [thres_1 I_img(i)];
%         else
%             thres_2 = [thres_2 I_img(i)];
%         end
%     end
%     mean_1 = mean(thres_1);
%     mean_2 = mean(thres_2);
%     if abs(t-(mean_1+mean_2)/2)<1
%         break
%     else
%         t = (mean_1+mean_2)/2;
%     end
% end
% I_1 = zeros(r,c);I_2 = zeros(r,c);
% a = find(img_gray>t);
% I_1(a) = img_gray(a);
% I_1_hist = histeq(I_1);
% b = find(img_gray<=t);
% I_2(b) = img_gray(b);
% I_2_hist = histeq(I_2);
% %第二次阈值处理后将图像进行直方图均衡处理
% figure;
% imshow(I_1);
% title('大于阈值');
% figure;
% imshow(I_2);
% title('小于阈值');
% % %canny_img = canny_img.*T;
% figure,
% subplot(181),imshow(img);
% title('原图')
% subplot(182),imshow(g);
% title('拉普拉斯锐化处理')
% subplot(183),imshow(J);
% title('直方图均衡');
% subplot(184),imshow(A);
% title('融合图像');
% subplot(185),imhist(img_gray,64);
% title('原图像直方图');
% subplot(186),imhist(J,64);
% title('均衡化后的直方图');
% subplot(187),imhist(g,64);
% title('拉普拉斯锐化后直方图');
% subplot(188),imhist(A,64);
% title('融合后直方图');
% g = img;
% 
% k_ = 0.1;
% K = zeros(r,c);
% window = 11;
% sita = (std2(img_gray))^2;
% for i=1+floor(window/2):r-floor(window/2)
%     for j=1+floor(window/2):c-floor(window/2)
%         sita_window = (std2(img_gray(i-floor(window/2):i+floor(window/2), j-floor(window/2):j+floor(window/2))))^2;
%         K(i,j) = k_*(sita_window^2 / sita^2)-k_;
%     end
% end
% disp(uint8(K));
% g = double(J) + K.*double(g);
% disp(g);
% figure;
% imshow(g);
% title('拉普拉斯锐化 融合 直方图均衡算法 图像增强');
% G = zeros(r,c);
% for i = 1:r
%     for j = 1:c
%         if img(i,j)^2>255
%             G(i,j)=255;
%         else
%             G(i,j) = img(i,j)^2;
%         end
%     end
% end
% 
if nargin == 1
    g = imclose(img, se);
end
if moshi == 1
    g = imerode(img, se); %g为腐蚀图像
elseif moshi == 2
    g = imopen(img, se);%g1为开运算
elseif moshi == 3
    g = imclose(img,se);%g2闭运算
elseif moshi == 4
    g2 = imclose(img, se);
    g = imopen(g2, se);%g3为闭开运算
elseif moshi == 5
    g =  imdilate(img, se);%g4为膨胀运算
elseif moshi == 6
    g1 = imopen(img, se);
    g2 = img-g1;
    g3 = imclose(img, se);
    g4 = g3 - img;
    
    g = g2+img-g4;
else
    err('param should be 1-5');
end

<<<<<<< HEAD
=======
%subplot(1,2,1),imshow(img),title('原图');
%subplot(1,2,2),imshow(img_close), title('腐蚀图像');
%}

%方法2：直方图和边缘细节处理（可带创新）
[r,c] = size(IMG);
max_index = max(max(IMG));
min_index = min(min(IMG));
index_hist = zeros(1,256);
for i=1:r
    for j=1:c
        index_hist(1,IMG(i,j)+1) = index_hist(1,IMG(i,j)+1) + 1;
    end
end
%
index_hist_p = double(index_hist./(r*c));
disp(index_hist_p);
%直方图均衡变换函数
%统计图像中每个灰度级像素的累积个数
for i = 1:256
    S(i) = sum(index_hist_p(1,1:i)); 
end

for i=1:256
    S(i) = S(i)*255;%灰度映射函数
    if S(i)>255
        S(i) = 2565; 
    end
end

%图像均衡化
I_equal = IMG;
for i=1:r
    for j=1:c
        I_equal(i,j) = S(IMG(i,j)+1);
    end
end
disp(S);


g=histeq(IMG);


img = double(IMG);
%g_sobel用sobel算子进行边缘检测
g_sobel=edge(img,'canny',0.09);
figure;
imshow(g_sobel);
title('自带SOBEL边缘检测');

%自适应系数
%窗口大小
w = 5;
%某一指定系数
k_ = 10;
%图像方差
sita_img = std2(img)^2;
%自适应系数
k=zeros(r,c);
for i=ceil(w/2):r-floor(w/2)
    for j = ceil(w/2):c-floor(w/2)
        %当前像素点的窗口邻域范围
        img_window = img(i-floor(w/2):i+floor(w/2),j-floor(w/2):j+floor(w/2));
        %窗口图像的方差
        sita_win = std2(img_window)^2;
        k(i,j) = k_*(sita_win/sita_img)-k_;
    end
end

g_adap_hist = zeros(r,c);
for i=1:r
    for j=1:c
        disp(k(i,j));
        disp(g_sobel(i,j));
        g_adap_hist(i,j) = g(i,j) + k(i,j)*g_sobel(i,j);
    end
end

subplot(141);
imshow(IMG);
title('原图');
subplot(142);
imshow(g);
title('直方图均衡化处理图像');
subplot(143);
imshow(g_sobel);
title('sobel边缘检测');
subplot(144);
imshow(uint8(g_adap_hist));
title('图像增强');
>>>>>>> 4dc2d0eeda4c3529df8e9d401985df70dba992d2
