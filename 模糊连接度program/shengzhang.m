function shengzhang( img )
%UNTITLED6 此处显示有关此函数的摘要
%   此处显示详细说明
figure;
imshow(img)
x = ginput(1);
axis on
hold on
[row,col] = size(img);
Q = [];
M = [];
M_x = [];M_y = [];

