%模糊连接度理论将图像进行分割
%新的邻近度函数？？
%多对象的相对模糊连接度算法？？？
%阈值自动选取？？？
%定义像素间的相似性和连续性，通过计算像素之间的 邻近度隶属函数 和   亲和度函数  表达其连续性和相似性

%邻近度隶属函数考虑空间距离信息，
%亲和度函数考虑图像像素信息




%基于区域生长
img = imread('30.jpg');
figure;
title('原图');
imshow(img);
%J是单种子区域生长后的种子图像
J = shengzhan(img);
disp(J);

[row, col] = size(img);
%将图片进行预处理
[img] = processing(img);
%隶属度函数
lishudu = lishudu_function(img);
%亲和度函数
qinhe = qinhe_function(img, lishudu);


%设置种子点
S=zeros(row,col);
S(60,60)=1;
S(65,60)=1;


%确定路径连接度
Plianjie(qinhe,S)
