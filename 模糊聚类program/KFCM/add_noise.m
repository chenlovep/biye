%clear;
%clc;
%I=imread('27.jpg');
%figure(1);
%imshow(I);
%title('原图');
function [disImg]=add_noise(I)
[row,col,nchannel]=size(I);
%In=awgn(I,3,'measured','linear');
disImg=uint8(double(I)+wgn(row,col,20));

%title('加噪声强度9%后');
%label_image=imread('E:\PROJECT code\biye\不同方法的分割结果\3%噪声分割');
%label_image_=uint8(label_image*255);
%disp(label_image_);
%figure(3);
%imshow(label_image_);