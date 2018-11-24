function [SA]=zhengquelv(B)
A=imread('E:\PROJECT code\biye\pred\4_json\label.png');%label标准图像



A=uint8(A*255);

[row,col]=size(A);

%kfcm
total_1=0;%总的像素
corr_1=0;%判断正确的像素数量
total_2=0;%总的像素
corr_2=0;%
total_3=0;%总的像素
corr_3=0;%
total_4=0;%总的像素
corr_4=0;%

IMG1=zeros(row,col);
IMG2=zeros(row,col);
IMG3=zeros(row,col);
IMG4=zeros(row,col);
%{
%正确率=分割后的图像/标注的图像
for i=1:row
    for j=1:col
        if B(i,j)== 160
            total_1=total_1+1;
        	IMG1(i,j)=255;
            if A(i,j)==255
                corr_1=corr_1+1;
            end
        elseif B(i,j)== 80
            total_2=total_2+1;
            IMG2(i,j)=255;
            if A(i,j)==255
                corr_2=corr_2+1;
            end
        elseif B(i,j)== 250
            total_3=total_3+1;
        	IMG3(i,j)=255;
            if A(i,j)==255
                corr_3=corr_3+1;
            end
        else
            total_4=total_4+1;
        	IMG4(i,j)=255;
            if A(i,j)==255
                corr_4=corr_4+1;
            end
            
        end
    end
end
figure(4);
imshow(IMG1);
figure(5);
imshow(IMG2);
figure(6);
imshow(IMG3);
figure(7);
imshow(IMG4);
disp(total_1);
disp(corr_1);
disp(total_2);
disp(corr_2);
disp(total_3);
disp(corr_3);
disp(total_4);
disp(corr_4);
SA=max(max(max(corr_1/total_1,corr_2/total_2),corr_3/total_3),corr_4/total_4);
%}

%正确率=label中标注的图像/分割后的分割内容图像
for i=1:row
    for j=1:col
        if A(i,j)==255
            total_1=total_1+1;
            if B(i,j)<120
                corr_1=corr_1+1;
                IMG1(i,j)=255;
            else 
                corr_2=corr_2+1;
                IMG2(i,j)=255;
            end
        end
    end
end
%{
figure(4);
imshow(IMG1);
figure(5);
imshow(IMG2);
figure(6);
imshow(IMG3);
figure(7);
imshow(IMG4);
disp(total_1);
disp(corr_1);
disp(total_2);
disp(corr_2);
disp(total_3);
disp(corr_3);
disp(total_4);
disp(corr_4);
%}
SA=max(max(max(corr_1/total_1,corr_2/total_1),corr_3/total_1),corr_4/total_1);

