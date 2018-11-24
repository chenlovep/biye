function [ center, U, obj_fcn ] = FCM_S(data, data1, cluster_n, alfa, options)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
%   输入
%data           ------nm矩阵，n个样本，每个样本具有m维特征值
%data1          ------nm矩阵，表示均值或者中值，均值为FCM_S1算法，中值为FCM_S2算法
%N_cluster      ------标量，表示聚合中心数目，类别数
%alfa           ------punishment factor
%options        ------4*1矩阵，
%               ------options(1)：隶属度矩阵U的指数，>1   ，缺省值2
%               ------options(2): 自大迭代次数            ，缺省值100
%               ------options(3): 隶属度最小变化量，迭代终止条件，缺省值1e-5
%               ------options(4): 每次迭代是否输出信息标志  ，缺省值1
%输出
%center         -------聚类中心
%U              -------隶属度矩阵
%obj_fcn        -------目标函数值
if nargin ~=4 & nargin~=5   %判断参数个数是4个还是5个
    error('Too many or too few input arguments');
end

data_n=size(data,1);   %表示样本个数
in_n=size(data,2);     %表示特征值长度
%默认操作参数
default_options=[2,100,1e-5,1];
if nargin == 4,
    options=default_options;
else       %分析有option做参数时候的情况
    if length(options)<4,  
        tmp=default_options;
        tmp(1:length(options))=options;
        options=tmp;
    end
    %返回options中是数的值为0，不是数时为1
    nan_index=find(isnan(options)==1);
    %将denfault_options中对应位置的参数赋值给options中不是数的位置
    options(nan_index)=default_options(nan_index);
    if options(1)<=1,
        error('The exponent should be greater than 1');
    end
end
    
%将options中的分量分别赋值给四个变量
expo=options(1);                  %隶属度矩阵U的指数
max_iter=options(2);              %最大迭代次数
min_impro=options(3);             %隶属度最小变化量，迭代终止条件
display=options(4);               %每次迭代是否输出信息标志
obj_fcn=zeros(max_iter,1);        %初始化输出参数obj_fcn

U=initfcm(cluster_n,data_n);      %初始化模糊分配矩阵，使U满足列上想加为1%U为（cluster_n,data_n）
%主循环
for i =1:max_iter
    
    %在每一个循环中改变聚类中心ceneter和分配函数U的隶属度值
    [U,center,obj_fcn(i)] = stepfcm(data,data1,U,cluster_n,expo,alfa);
    if display,
        fprintf('FCM:Iteration count=%d,obj.fcn=%f\n',i,obj_fcn(i));
    end
    
    %终止条件判别
    if i>1,
        if abs(obj_fcn(i)-obj_fcn(i-1))<min_impro,
            break;
        end
        %if sum(sum(abs(U-U0)))<1
        %    break;
        %end
    end
end
iter_n=i;
obj_fcn(iter_n+1:max_iter)=[];
end

