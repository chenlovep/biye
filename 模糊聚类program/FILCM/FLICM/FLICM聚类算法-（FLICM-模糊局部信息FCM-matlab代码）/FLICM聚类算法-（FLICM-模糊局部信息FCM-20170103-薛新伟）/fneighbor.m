function [neipos,wid]=fneighbor(I,width)
% neighbor_pos每个窗函数内的邻域位置
% wid邻域内每个点和中心点的欧式距离
% I为图像矩阵
% width窗函数的宽度
[m,n]=size(I);
I_position=zeros(m,n);
I_position(:)=1:m*n;     %初始化位置窗口
cet=floor(width/2)+1;    %窗函数的中心位置
%计算wid
for i=1:width
    for j=1:width
        wid((j-1)*width+i)=sqrt((i-cet)^2+(j-cet)^2);%使用到矩阵的线性寻址
    end
end
wid=wid';
%扩展边缘
half_w=floor(width/2);
extended_image1=[I_position(:,1:half_w), I_position, I_position(:,(end-half_w+1):end)];   %扩展列
extended_image=[extended_image1(1:half_w,:); extended_image1; extended_image1(end-half_w+1:end,:)];  %扩展行
neipos=zeros(width*width,m*n);
for i=1:m
    for j=1:n
        temp=extended_image(i:i+2*half_w,j:j+2*half_w);
        neipos(:,(j-1)*m+i)=temp(:);                    %矩阵线性寻址
    end
end
cet_pos=(cet-1)*width+cet;
%删除自己到自己的情况
wid(cet_pos)=[];                  
neipos(cet_pos,:)=[];
        