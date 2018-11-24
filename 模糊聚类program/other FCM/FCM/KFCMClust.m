function [center, U, obj_fcn] = KFCMClust(data, cluster_n, kernel_b,options)
% FCMClust.m   采用模糊C均值对数据集data聚为cluster_n类 
%
% 用法：
%   1.  [center,U,obj_fcn] = KFCMClust(Data,N_cluster,kernel_b,options);
%   2.  [center,U,obj_fcn] = KFCMClust(Data,N_cluster,kernel_b);
%   3.  [center,U,obj_fcn] = KFCMClust(Data,N_cluster);
%   
% 输入：
%   data        ---- nxm矩阵,表示n个样本,每个样本具有m的维特征值
%   N_cluster   ---- 标量,表示聚合中心数目,即类别数
%   kernel_b    ---- 高斯核参数b                           （缺省值：150）
%   options     ---- 4x1矩阵，其中
%       options(1):  隶属度矩阵U的指数，>1                  (缺省值: 2.0)
%       options(2):  最大迭代次数                           (缺省值: 100)
%       options(3):  隶属度最小变化量,迭代终止条件           (缺省值: 1e-5)
%       options(4):  每次迭代是否输出信息标志                (缺省值: 1)
% 输出：
%   center      ---- 聚类中心
%   U           ---- 隶属度矩阵
%   obj_fcn     ---- 目标函数值
%   Example:
%       data = rand(100,2);
%       [center,U,obj_fcn] = KFCMClust(data,2);
%       plot(data(:,1), data(:,2),'o');
%       hold on;
%       maxU = max(U);
%       index1 = find(U(1,:) == maxU);
%       index2 = find(U(2,:) == maxU);
%       line(data(index1,1),data(index1,2),'marker','*','color','g');
%       line(data(index2,1),data(index2,2),'marker','*','color','r');
%       plot([center([1 2],1)],[center([1 2],2)],'*','color','k')
%       hold off;

%   Author: Genial
%   Date:   2005.5

%  一副图中显示多方图片：montage


error(nargchk(2,4,nargin));    %检查输入参数个数

data_n = size(data, 1); % 求出data的第一维(rows)数,即样本个数
in_n = size(data, 2);   % 求出data的第二维(columns)数，即特征值长度,目前没有用
% 默认操作参数
default_b = 150;         % 高斯核函数参数
default_options = [2;	% 隶属度矩阵U的指数
    100;                % 最大迭代次数 
    1e-5;               % 隶属度最小变化量,迭代终止条件
    1];                 % 每次迭代是否输出信息标志 

if nargin == 2,
    kernel_b = default_b;
	options = default_options;
elseif nargin == 3,
    options = default_options;
else    %分析有options做参数时候的情况
	% 如果输入参数个数是3那么就调用默认的option;
    %如果用户给的opition数少于4个那么就将剩余的默认option加上;
	if length(options) < 4, 
		tmp = default_options;
		tmp(1:length(options)) = options;
		options = tmp;
    end
    % 返回options中是数的值为0(如NaN),不是数时为1
	nan_index = find(isnan(options)==1);
    %将denfault_options中对应位置的参数赋值给options中不是数的位置.
	options(nan_index) = default_options(nan_index);
	if options(1) <= 1,
        %如果options中的指数m不超过1报错
		error('The exponent should be greater than 1!');
	end
end
%将options 中的分量分别赋值给四个变量;
expo = options(1);          % 隶属度矩阵U的指数
max_iter = options(2);		% 最大迭代次数 
min_impro = options(3);		% 隶属度最小变化量,迭代终止条件
display = options(4);		% 每次迭代是否输出信息标志 

obj_fcn = zeros(max_iter, 1);	% 初始化输出参数obj_fcn
U = initkfcm(cluster_n, data_n);	% 初始化模糊分配矩阵,使U满足列上相加为1

% 初始化聚类中心：从样本数据点中任意选取cluster_n个样本作为聚类中心。当然，
% 如果采用某些先验知识选取中心或许能够达到加快稳定的效果，但目前不具备这功能
index = randperm(data_n);   % 对样本序数随机排列
center_old = data(index(1:cluster_n),:);  % 选取随机排列的序数的前cluster_n个

% Main loop  主要循环
for i = 1:max_iter,
    %在第k步循环中改变聚类中心ceneter,和分配函数U的隶属度值;
	[U, center, obj_fcn(i)] = stepkfcm(data,U,center_old, expo, kernel_b);
	if display, 
		fprintf('KFCM:Iteration count = %d, obj. fcn = %f\n', i, obj_fcn(i));
    end
    center_old = center;    % 用新的聚类中心代替老的聚类中心
	% 终止条件判别
	if i > 1,
		if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end,
	end
end

iter_n = i;	% 实际迭代次数 
obj_fcn(iter_n+1:max_iter) = [];


% 子函数
function U = initkfcm(cluster_n, data_n)
% 初始化fcm的隶属度函数矩阵
% 输入:
%   cluster_n   ---- 聚类中心个数
%   data_n      ---- 样本点数
% 输出：
%   U           ---- 初始化的隶属度矩阵
U = rand(cluster_n, data_n);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :);



% 子函数
function [U_new,center_new,obj_fcn] = stepkfcm(data,U,center,expo,kernel_b)
% 模糊C均值聚类时迭代的一步
% 输入：
%   data        ---- nxm矩阵,表示n个样本,每个样本具有m的维特征值
%   U           ---- 隶属度矩阵
%   center      ---- 聚类中心
%   expo        ---- 隶属度矩阵U的指数         
%   kernel_b    ---- 高斯核函数的参数
% 输出：
%   U_new       ---- 迭代计算出的新的隶属度矩阵
%   center_new  ---- 迭代计算出的新的聚类中心
%   obj_fcn     ---- 目标函数值
feature_n = size(data,2);  % 特征维数
cluster_n = size(center,1); % 聚类个数
mf = U.^expo;       % 隶属度矩阵进行指数运算（c行n列)

% 计算新的聚类中心;根据(5.15）式
KernelMat = gaussKernel(center,data,kernel_b); % 计算高斯核矩阵(c行n列)
num = mf.*KernelMat * data;   % 式(5.15)的分子(c行p列,p为特征维数)
den = sum(mf.*KernelMat,2);   % 式子(5.15)的分子，(c行,1列,尚未扩展)
center_new = num./(den*ones(1,feature_n)); % 计算新的聚类中心(c行p列,c个中心)

% 计算新的隶属度矩阵；根据(5.14)式子
kdist = distkfcm(center_new, data, kernel_b);    % 计算距离矩阵
obj_fcn = sum(sum((kdist.^2).*mf));  % 计算目标函数值 (5.11)式
tmp = kdist.^(-1/(expo-1));     
U_new = tmp./(ones(cluster_n, 1)*sum(tmp)); 



% 子函数
function out = distkfcm(center, data, kernel_b)
% 计算样本点距离聚类中心的距离
% 输入：
%   center     ---- 聚类中心
%   data       ---- 样本点
% 输出：
%   out        ---- 距离
cluster_n = size(center, 1);
data_n = size(data, 1);
out = zeros(cluster_n, data_n);
for i = 1:cluster_n % 对每个聚类中心 
    vi = center(i,:);
    out(i,:) = 2-2*gaussKernel(vi,data,kernel_b);
end



% 子函数
function out = gaussKernel(center,data,kernel_b)
% 高斯核函数计算
% 输入:
%   center      ---- 模糊聚类中心
%   data        ---- 样本数据点
%   kernel_b    ---- 高斯核参数
% 输出：
%   out         ---- 高斯核计算结果
if nargin == 2
    kernel_b = 150;
end
dist = zeros(size(center, 1), size(data, 1));
for k = 1:size(center, 1), % 对每一个聚类中心
    % 每一次循环求得所有样本点到一个聚类中心的距离
    dist(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
end
out = exp(-dist.^2/kernel_b^2);




