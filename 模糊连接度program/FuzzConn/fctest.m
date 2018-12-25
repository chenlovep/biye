%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fuzzy connectedness segmentation example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;
%Read image and scale to [0,1]
I = double(imread('30.jpg'));
figure;
title('原图');
imshow(I);
[kseedsx, kseedsy] = SLIC(I);
disp(kseedsx);
disp(kseedsy);
%M为种子点数量
M = 1;point_seed_x=[];point_seed_y = [];I_kseed=[];
for i =1:length(kseedsx)
    I_kseed = [I_kseed I(floor(kseedsx(i)), floor(kseedsy(i)))];
end
disp(I_kseed);
for i=1:M
    point = find(max(I_kseed));
    point_seed_x = [point_seed_x floor(kseedsx(point))];
    point_seed_y = [point_seed_y floor(kseedsy(point))];
    I_kseed(point) = [];
end
disp(point_seed_x);
disp(point_seed_y);
%超像素分割确定区域生长的初始种子点
Super_peiels(I);

%{
[r,c]=size(I);
[I_g] = processing(I);
I_g = (I_g +I)/2;
%Compute adjacency
%计算邻接Uα(c,d)
n=1;
k1=0.1;
%A表示图像中任意两点的邻接度Uα(c,d)
%A(r*c,r*c)
%图像中只有当前点和其4邻域的像素点具有邻接度，其余为0
A=adjacency(I_g, n, k1);

%Compute affinity
%计算亲和度
k2=2;
K=affinity(I_g, A, k2);


%Seed points, numbered from 1 and up
k=6;%种子点选取的个数
[S] = shengzhan(I_g, k);
%disp(x*128);disp(y*128);
%S(75:80,25:30)=1; %coat
%S(60:65,40:45)=1; %hand
%S(110:115,20:25)=1; %leg

%S(10:15,80:85)=2; %sky
%S(100:105,110:125)=3; %grass

%Show seeds overlayed on image
I_rgb=repmat(I,[1,1,3]); %make rgb image (required by imoverlay)

figure(1)
image(I_rgb)
imoverlay(S,S>0); %requires image in range [0,1]
title('Seed regions');


%Compute FC
%图像中所有像素点相对种子点的模糊连接度矩阵FC
%K亲和度矩阵
%S为种子点矩阵，mask表示
%S为mask图像,K为模糊亲和度
disp(sprintf('Processing...'));
FC=afc(S,K); %Absolute FC

%Show resulting FC-map
figure(2)
%将FC图像由0-1显示
imagesc(FC,[0,1])
colorbar
title('Fuzzy connectedness map');

%Threshold value
%thresh=0.79;

[thresh] = mohuzhi(FC);
disp(thresh);
%Show the 0.75-connected component overlayed on original image
figure(3)
image(I_rgb);

imoverlay(FC,FC>0);
title(sprintf('Fuzzy connected component at level %.2f',thresh));
%}
