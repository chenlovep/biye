function [IX,times,IMMRF]=BianXiangsuLeibie2(maxX,maxY,StruInfo,gauss,IX,times)    

%times=0;
IX1=zeros(maxX,maxY);

temp1=StruInfo.*gauss;
%进行图像的遍历
for i=1:maxX
    for j=1:maxY
        tmp=max(temp1(i,j,:));
        %tmp为每个像素值所对应的P(W/S)的最大值
        for k=1:4
            if tmp==temp1(i,j,k)
                %将第(i,j)位置的像素进行重新更新标签
                IX1(i,j)=k;
            end
        end
        
        if IX(i,j)==IX1(i,j)
            IX(i,j)=IX1(i,j);
        else
            times=times+1;
            IX(i,j)=IX1(i,j);                       %取xij概率最大者
        end
        %IX为更新前的标签矩阵，将IX进行更新
    end
end

%将分类过后的图像进行类别显示化
%用灰度250,160,80,0分别代表4种不同类别的表示
IMMRF=zeros(maxX,maxY);

for i=1:maxX
    for j=1:maxY
        if IX(i,j)==4
            IMMRF(i,j)=80;
        elseif IX(i,j)==3
            IMMRF(i,j)=160;                           %由类别分象素
        elseif IX(i,j)==2
            IMMRF(i,j)=250;
        else
            IMMRF(i,j)=0;
        end
    end
end
IMMRF1=uint8(IMMRF);
%figure(3);
%imshow(IMMRF1);

