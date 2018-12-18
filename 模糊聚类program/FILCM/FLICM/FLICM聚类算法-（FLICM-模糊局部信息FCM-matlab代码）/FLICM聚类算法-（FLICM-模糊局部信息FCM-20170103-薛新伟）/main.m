%A robust fuzzy local information c-means clustering algorithm
%write by 2016-10-28
%本程序难点：模糊因子Gki的构建
clear all;
close all;
clc
path='27.jpg';
tic;%tic %保留这一时刻
t6=clock;
eval(['info=imfinfo(path)']);
switch info.ColorType
    case 'truecolor'    %真彩色图片
       eval(['RGB=imread(path);']);
       I=rgb2gray(RGB);
       clear RGB;
    case 'indexed'      %索引图片
       eval(['[X,map]=imread(path);']);
       I=ind2gray(X,map);
       clear X;
    case 'grayscale'     %灰度图像
        eval(['I=imread(path);']);
end
% I=[ones(128,64)*20,ones(128,64)*120];
% I=uint8(I);
% I = imresize(I, [318 480]);
figure,imshow(I);
title('原始图片');
[m,n]=size(I);
pic=I;
%I = uint8(double(I) + wgn(m, n, 15));
%I=imnoise(I,'gaussian',0,0.02);
% I=imnoise(I,'salt & pepper',0.2);
figure,imshow(I);
title('添加噪声的图片');
picc=I;


width=3;                 %设置窗函数的大小
%窗函数的位置信息
[neipos,wid]=fneighbor(I,width);
%处理图像数据
I=double(I);
data = reshape(I, numel(I), 1); %将图像数据转化为一列数据
%参数初始化
options=[2;300;1e-5;0];
cluster_n=4;                    %聚类类别数
[center,U,obj_fcn,iter_n]=myfcm(data,neipos,wid,cluster_n,options);%调用FCM函数
%输出聚类结果
maxU=max(U);%返回隶属度矩阵每一列的最大值
temp=sort(center);%对数组每列进行升序排列
disp(size(maxU));
disp(size(U));
for n=1:cluster_n   %按聚类结果分割图像
    eval(['cluster',int2str(n), '_index = find(U(', int2str(n), ',:) == maxU);']);
    %含义：在隶属度矩阵中的第n行找到属于该行的最大隶属度的索引号
    %即索引号对应元素属于第n类
    index=find(temp==center(n));
    %找到原聚类中心在升序聚类中心的索引号
    switch index
        case 1
            color_class=0;
        case 2
            color_class=80;
        case 3
            color_class=160;
        case cluster_n
            color_class=255;
        otherwise
%             color_class=fix(255*(index-1)/(cluster_n-1));
            color_class=128;
    end
    eval(['I(cluster',int2str(n), '_index(:))=', int2str(color_class),';']);
    %直接利用矩阵的线性寻址进行赋值
end
% I=mat2gray(I);%%%%%这个是我给屏蔽的，原来意思是2值化了
figure,imshow(uint8(I));
title('FLICM分割后图片');
% imwrite(I,'FLICM999.bmp');
disp(['运行时间：',num2str(etime(clock,t6))])
imwrite(uint8(I),'FLICM噪声.jpg');
imwrite(uint8(255-I),'局部模糊信息与马尔科夫结合NCMFLICM9991.bmp');

%分割质量评价
% [Vpc,Vpe,Vxb,SA]=evaluation(data,U,cluster_n,center,I);
% fprintf('图像的划分系数=%d,划分熵=%d,正确分割率=%d\n',Vpc,Vpe,SA);

