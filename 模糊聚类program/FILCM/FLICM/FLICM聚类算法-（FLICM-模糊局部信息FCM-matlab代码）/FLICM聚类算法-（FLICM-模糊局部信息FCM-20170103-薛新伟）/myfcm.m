function [center,U,obj_fcn,iter_n]=myfcm(data,neipos,wid,cluster_n,options)%调用FCM函数
if nargin~=4 && nargin~=5
    error('参数太多或太少');
end
data_n=size(data,1);
in_n=size(data,2);
%参数初始化
expo=options(1);       %FCM中的参数m
max_iter=options(2);   %最大迭代次数
min_impro=options(3); %迭代终止条件
display=options(4);   %迭代过程是否显示
obj_fcn=zeros(max_iter,1);%目标函数值数组
%初始化隶属度矩阵
U=myfcminit(cluster_n,data_n);
%循环主体
for i=1:max_iter
    Uold=U;
%     if i>1
%         center1=center;
%     end
    [U,center,obj_fcn(i)]=myfcmstep(data,neipos,wid,U,cluster_n,expo);%调用函数进行一步迭代
    if display==1
        fprintf('迭代次数=%d,obj.fcn=%f\n',i,obj_fcn(i));
    end
    if i>1
        if(norm(U-Uold,Inf))< min_impro
%         if(sqrt(sum((center1-center).^2)))<min_impro
            break;
        end
    end
end
iter_n=i;     %iter_n为实际迭代次数
obj_fcn(iter_n+1:max_iter)=[];
