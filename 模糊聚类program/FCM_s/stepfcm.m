function [U_new, center, obj_fcn] = stepfcm(data,data1,U,cluster_n,expro,alfa)
%模糊C均值聚类时迭代的一步
%data             n个样本，每个样本有m维特征值
%data1            nm矩阵，表示均值或者中值，均值为fcm_s1,中值为fcm_s2
%U                隶属度矩阵
%cluster_n        表示类别数
%expo             隶属度矩阵U的指数
%alfa             punishment factor
%   此处显示详细说明
%U_new            新的隶属度矩阵
%center           新的聚类中心
%obj_fcn          目标函数值
mf=U.^expro;       %隶属度矩阵进行指数运算结果
%新聚类中心
center = mf*(data+alfa*data1)./((ones(size(data,2),1)*sum(mf'))'*(1+alfa));
%计算距离矩阵
dist = distfcm(center, data);
dist1 = distfcm(center, data1);
%计算目标值
obj_fcn = sum(sum((dist.^2).*mf))+alfa*sum(sum((dist1.^2).*mf)); %计算目标函数值
tmp = (dist.^2+alfa*dist1.^2).^(-1/(expro-1));
%计算新的隶属度矩阵
U_new = tmp./(ones(cluster_n,1)*sum(tmp));

end

