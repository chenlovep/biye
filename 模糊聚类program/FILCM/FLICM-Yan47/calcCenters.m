function [center] =calcCenters(image, U, cNum, m)
% input
    % image:0-255的double型
    % U：0-1的double型
    % cNum：聚类中心数目
    % m：控制收敛速度的参数，通常为2
% output
    % center：长度为cNum的向量
center=zeros(cNum,1);
mf=U.^m;
for k=1:cNum
    sSum=sum(sum(mf(:,:,k)));
    center(k)=sum(sum(mf(:,:,k).*image))/sSum; %得到聚类中心   
end

%函数结束
end