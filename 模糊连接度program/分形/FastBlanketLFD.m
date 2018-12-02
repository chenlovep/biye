function [ D E S ] = FastBlanketLFD( Imag, epsilon )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[row,col] = size(Imag);
U=zeros(row,col,epsilon);
B=zeros(row,col,epsilon);
U0=zeros(row,col,1);
B0=zeros(row,col,1);
%初始化，坛子厚度epsilon为0时，两个表面定义为原始表面灰度
U0=Imag;
B0=Imag;       %U上表面，B下表面
%第1层毯子(尺度1)的两个表面
for j=1:col
    for i=1:row
        %设置(i,j)点的上、下、左、右四个方向
        if i==1
            up = i;
        else 
            up = i-1;
        end
        if j == 1
            left = j;
        else 
            left = j-1;
        end
        if i == row
            down = i;
        else
            down = i+1;
        end
        if j == col
            right = j;
        else
            right = j+1;
        end
        if abs(i-j)/2 == 0
            U(i,j,1) = max(U0(i,j,1)+1,max(U0(i,j,1),max(max(U0(up,j,1),U0(i,left,1)),max(U0(down,j,1),U0(i,right,1)))));
            B(i,j,1) = min(B0(i,j,1)-1,min(B0(i,j,1),min(min(B0(up,j,1),B0(i,left,1)),min(B0(down,j,1),B0(i,right,1)))));
        else
            U(i,j,1) = Imag(i,j);
            B(i,j,1) = Imag(i,j);
        end
    end
end
%计算各个尺度的表面积
Area = zeros(1,epsilon);
Area(1,1) = sum(sum(U(:,:,1)-B(:,:,1)))/2;
temp=Area(1,1);
for p=2:epsilon
    Area(1,p) = (Area(1,1)+(p-1)*row*col/2)/p;
end
%拟合分维d
log_x = log(1:epsilon);
log_y = log(Area);

K = polyfit(log_x(1:epsilon),log_y(1:epsilon),1);
D = 2-K(1);
S = K(2);

%计算分形误差
E = 0;
for p = 2:epsilon
    E = E+(log_y(p)-K(1)*log_x(p)-K(2))*(log_y(p)-K(1)*log_x(p)-K(2));
end

end

