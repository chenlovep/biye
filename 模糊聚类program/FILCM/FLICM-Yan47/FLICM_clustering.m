function [imOut,iter] = FLICM_clustering( imgFileName, cNum, m, winSize, maxIter, thrE )
%FLICM_clustering
%
% Usage:   [imOut,iter] = FLICM_clustering( imgFileName, cNum, m, winSize, maxIter, thrE )
% Inputs: 
%   imgFilename    Filename of the input image.
%   cNum           Number of clusters.
%   m              Weighting exponent on each fuzzy membership.
%   winSize        Size of the local window.
%   maxIter        Maximum number of iterations.
%   thrE           Threshold that stops the algorithm.
% Outputs:
%   imOut          The clustered image.
%   iter           The number of iterations made by the algorithm.
%
% Running example:
%   [imOut,iter] = FLICM_clustering('brain.tif',3,2,3,500,0.001);
%   figure, imshow(imOut)
%
%   author: Yan_47根据Krinidis Stelios的论文：Krinidis S, Chatzis V. A robust fuzzy local information C-means clustering algorithm[J]. 
%   IEEE Transactions on Image Processing, 2010, 19(5): 1328-1337.写的matlab实现。
%   E-mail： yan_siqi@qq.com
%   2016/12/7 to run on Matlab R2014a 



% 载入图像
image = imread( imgFileName );%0-255的Uint8型
if( size(image,3)>1 )%对彩色图像，转化为灰度图像
    image = rgb2gray( image );
end
image = double( image );%0-255的double型

% 随机初始化隶属度矩阵U,大小为(H,W,cNum)
[H,W] = size( image );
U=rand(H,W,cNum);
col_sum=sum(U,3);
U=U./col_sum(:,:,ones(cNum,1)); %构造一个维数相同的矩阵，第3维除以1相当于没除

% FLICM
[U,iter] = FLICM( image, H, W, U, m, cNum, winSize, maxIter, thrE );

% Create output image
cmap = hsv(cNum);
[~,clus] = max( U, [], 3 );
Ir = zeros(size(image));    Ig = zeros(size(image));    Ib = zeros(size(image));
for i=1:cNum
    q = find( clus==i );
    Ir(q) = round(cmap(i,1)*255);
    Ig(q) = round(cmap(i,2)*255);
    Ib(q) = round(cmap(i,3)*255);
end
imOut(:,:,1) = uint8(Ir);
imOut(:,:,2) = uint8(Ig);
imOut(:,:,3) = uint8(Ib);

%函数结束
end