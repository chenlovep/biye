function U=myfcminit(cluster_n,data_n)
%U为隶属度矩阵，大小为：分类个数*数据元素个数
%cluster_n为分类个数，data_n为数据元素的个数
U=rand(cluster_n,data_n);%随机生成隶属度矩阵
col_sum=sum(U);          %计算隶属度每列元素和
U=U./col_sum(ones(cluster_n,1),:);%保证数据点到各聚类中心的隶属度和为1