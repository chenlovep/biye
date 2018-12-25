function Super_peiels( I )
%利用超像素自动分割多目标或者单目标器官的方法

%将图像划分为n个区域，代表图像拥有n个超像素
[row, col] = size(I);
n = 20;
%超像素边长
S_super_peiels = sqrt(row*col/n);
%利用图像梯度向量，减少边缘不清晰或噪声较多等对聚类的干扰
for r = 2:row-1
    for c = 2:col-1
        tidu_x = I(r+1,c+1)+ 2*I(r,c+1)+ I(r-1,c+1) - I(r-1,c-1)-2*I(r, c-1) - I(r+1,c-1);
        tidu_y = I(r-1,c-1)+2*I(r-1,c)+I(r-1,c+1) - I(r+1,c-1)-2*I(r+1,c)-I(r+1,c+1);
        tidu((r-1)*col + c) = sqrt(tidu_x^2 + tidu_y^2);
    end
end
%将图像中梯度向量最小的像素找出，确定为初始的超像素聚类中心点
%初始聚类中心坐标(x_,y_)
[min_tidu,index] = min(tidu);
x_ = ceil(index/col);
y_ = index - (x_-1)*col;

end

