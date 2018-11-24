function [U_new, center, obj_fcn] = stepfcm(data, U, cluster_n, expo)
% 模糊C均值聚类时迭代的一步
% 输入：
%   data        ---- nxm矩阵,表示n个样本,每个样本具有m的维特征值
%   U           ---- 隶属度矩阵
%   cluster_n   ---- 标量,表示聚合中心数目,即类别数
%   expo        ---- 隶属度矩阵U的指数                      
% 输出：
%   U_new       ---- 迭代计算出的新的隶属度矩阵
%   center      ---- 迭代计算出的新的聚类中心
%   obj_fcn     ---- 目标函数值
mf = U.^expo;       % 隶属度矩阵进行指数运算结果
center = mf*data./((ones(size(data, 2), 1)*sum(mf'))'); % 新聚类中心(5.4)式
dist = distfcm(center, data);       % 计算距离矩阵
obj_fcn = sum(sum((dist.^2).*mf));  % 计算目标函数值 (5.1)式
tmp = dist.^(-2/(expo-1));
U_new = tmp./(ones(cluster_n, 1)*sum(tmp));  % 计算新的隶属度矩阵 (5.3)式
% tmp = dist.^(2/(expo-1));
% U_new =ones(cluster_n, size(data,1))./(tmp.*(ones(cluster_n,1)*sum(ones(cluster_n, size(data,1))./tmp)));