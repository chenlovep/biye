function [U,iter] =FLICM( image, H, W, U, m, cNum, winSize, maxIter, thrE )
%input 
%   image:0-255的double型
%output 
%   U:维度为(H,W,cNum)，0-1的double型
sStep = (winSize-1)/2; %局部窗口半径
center=calcCenters( image, U, cNum, m);%利用初始隶属度矩阵，计算初始聚类中心
iter = 0;%迭代次数
dMax = 10.0;%先初始化一个较大的值，|U_new-U_old|
Uold=U;%Uold下面要用
d1=zeros(cNum,1);%d1为公式（17）中的G_ki
d2=zeros(cNum,1);%d2为公式（19）中的分母的前半部分
while( (dMax>thrE) && iter<=maxIter )%步骤6
    for i=1:H
        for j=1:W
            for k=1:cNum
                sSum=eps(0);%重置sSum
                for ii=-sStep:sStep %sStep是窗口半径，ii和jj是对局部区域计算
                    for jj=-sStep:sStep
                        x=i+ii;
                        y=j+jj;
                        dist=sqrt((x-i)^2+(y-j)^2);%局部区域中，点（x,y）和点（i,j）的距离
                        if(x >= 1 && x <= H && y >= 1 && y <= W && (ii ~= 0 || jj ~= 0))%（x,y）不能超过边界，也不能与（i,j）重合
                            val=image(x,y);%i的邻域点j点的灰度值，公式（17）
                            sSum=sSum+1.0/(1.0+dist)*(1-Uold(x,y,k).^m)*abs(val-center(k))^2;%距第k个聚类中心的距离
                        end
                    end
                end
                d1(k)=sSum;%d1为公式（17）中的G_ki
                d2(k)=abs(image(i,j)-center(k))^2;
            end
            d1(d1==0)=eps(0);%接近于0的极小值
            d2(d2==0)=eps(0);%接近于0的极小值
            for k=1:cNum
                dd = d1(k)+d2(k);%每个k都用到了
				sSum = eps(0);%每次都要置为0
                for ii=1:cNum
                    sSum =sSum+(dd/(d1(ii)+d2(ii)))^(1.0/(m-1.0)); %公式(19),分子不变，分母一直在变
                end
				U(i,j,k)= 1.0 / sSum;
            end
        end
    end
    cenOld=center;
    center=calcCenters( image, U, cNum, m);%利用旧隶属度矩阵，计算初始聚类中心
    dMax= max(abs(cenOld-center));
    Uold = U;    %更新隶属度矩阵
    iter=iter+1; %记录迭代次数
end


%函数结束
end