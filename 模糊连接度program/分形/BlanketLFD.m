function D = BlanketLFD(Imag, epsilon)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
[row,col] = size(Imag);
U = zeros(row,col,epsilon);
B = zeros(row,col,epsilon);
%初始化，坛子厚度epsilon为0时，两个表面定义为原始表面灰度
U(:,:,1) = Imag;%U上表面
B(:,:,1) = Imag;%B下表面

for p = 2:epsilon
   for j = 1:col
       for i = 1:row
           %设置(i,j)点的上、下、左、右四个方向
           if i==1
               up = i;
           else
               up = i-1;
           end
           if j==1
               left = j;
           else
               left = j-1;
           end
           if i==row
               down = i;
           else
               down = i+1;
           end
           if j == col
               right = j;
           else
               right = j+1;
           end
           U(i,j,p) = max(U(i,j,p-1)+1,max(U(i,j,p-1),max(max(U(up,j,p-1),U(i,left,p-1)),max(U(down,j,p-1),U(i,right,p-1)))));
           B(i,j,p) = min(B(i,j,p-1)-1,min(B(i,j,p-1),min(min(B(up,j,p-1),B(i,left,p-1)),min(B(down,j,p-1),B(i,right,p-1)))));
       end
   end
end
%计算体积
Volume = zeros(epsilon,1);
V_temp = zeros(row,col);

for p = 1:epsilon
    V_temp(:,:) = U(:,:,p)-B(:,:,p);
    Volume(p,1) = sum(sum(V_temp));
end
%计算整幅图像表面积
Area = zeros(1,epsilon);
Area(1,1) = 1;
for p=2:epsilon
    Area(1,p) = Volume(p,1)/2*p; 
end
%拟合分维
log_x = log(1:epsilon);
log_y = log(Area);
K = polyfit(log_x(2:epsilon),log_y(2:epsilon),1);
D = 2-K(1);
end