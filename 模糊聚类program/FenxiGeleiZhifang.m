%
%IX为标签矩阵，每个元素值代表其对应的类别，在此处为1-4类
%IM为输入分割图像，MaxX，maxY为图像对应大小
function [y1,y2,y3,y4]=FenxiGeleiZhifang(IX,IM,maxX,maxY)

num1=0;
num2=0;
num3=0;
num4=0;

y1=zeros();y2=zeros();y3=zeros();y4=zeros();
%对图像进行遍历
for i=1:maxX
    for j=1:maxY
        if IX(i,j)==1
            num1=num1+1;
            y1(num1)=IM(i,j);
        elseif IX(i,j)==2
            num2=num2+1;
            y2(num2)=IM(i,j);
        elseif IX(i,j)==3
            num3=num3+1;
            y3(num3)=IX(i,j);
        else
            num4=num4+1;
            y4(num4)=IM(i,j);
        end
    end
end
l=0;
