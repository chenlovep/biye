clc;
clear all;
close all;

%[filename,path] = uigetfile({'*.tif;*.bmp;*.jpg;*.png'});
%path = fullfile(path,filename);
%img=imread(path);
    %img=rgb2gray(img);
img=imread('27.jpg');
img=add_noise(img);
figure;
imshow(img);
imwrite(img, '噪声20%的图像.jpg');
tic;
[r,c]=size(img);
width=7; %局部窗尺寸
delta = (width-1)/2;
img1=img;
for i = delta+1:r-delta
    for j = delta+1:c-delta
        %img1(i,j) = sum(sum(img(i-delta:i+delta,j-delta:j+delta)))/(width*width);
        temp = img(i-delta:i+delta,j-delta:j+delta);
        temp=sort(temp(:));
        img1(i,j)=temp((length(temp)+1)/2);%取中值为FCM_S2算法
    end
end
data=zeros(r*c,1);
data1=zeros(r*c,1);
for i=1:r
    for j=1:c
        data((i-1)*c+j,1)=double(img(i,j));
        data1((i-1)*c+j,1)=double(img1(i,j));
    end
end

[center,U,obj_fcn] = FCM_S(data,data1,4,3);
%计算分割系数Vpc
Vpc=0;
%计算分割熵
Vpe=0;
[Ucluster_n,Udata_n]=size(U);
for i=1:Ucluster_n
    for j=1:Udata_n
        Vpc=Vpc+(U(i,j)^2);
        Vpe=Vpe+U(i,j)*log(U(i,j));
    end
end
Vpc=Vpc/Udata_n;
Vpe=-Vpe/Udata_n;
disp('-----------分割系数Vpc-------------');
disp(Vpc);
disp('-----------分割熵Vpe---------------');
disp(Vpe);

[r,c] = size(img);
img_seg = img*0;

for i=1:r
    for j=1:c
        temp=U(:,(i-1)*c+j);
        [a,b]=max(temp);
        img_seg(i,j)=b;
    end
end

figure;
imshow(uint8(img));
figure;
imagesc(label2rgb(img_seg,'jet','w','shuffle'));
axis image
axis off;
set(gca, 'position', [0 0 1 1]);
axis normal;
A=zeros(r,c);
for i =1:r
    for j=1:c
        if img_seg(i,j)==1
            A(i,j)=80;
        elseif img_seg(i,j)==2
            A(i,j)=250;
        elseif img_seg(i,j)==3
            A(i,j)=160;
        else
            A(i,j)=0;
        end
    end
end

A=uint8(A);
imshow(A)
imwrite(A,'分割后图像.jpg');
SA=zhengquelv(A);
disp(SA);
toc;












