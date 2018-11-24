function [lof] = aerfa(X)
%LOF算法
%dist为m*m的距离矩阵每一行代表一个数据与其它数据距离的列向量，所以该矩阵为
%对角线为0的，关于对角线对称的矩阵,K为k-近邻
%function lof = LOF(IM,K)
%A=importdata('data.mat');%需要进行离群因子算法处理的数据集
%numData=size(A,1);
%for i=1:1:numData
%[~,dist]=knnsearch(A(i,:),A(:,:));
%KD=[KD;dist'];
%end

count=0;
for i=1:3
    for j=1:3
        count=count+1;
        IM(count)=X(i,j);        
    end
end
disp(IM)
disp(count)
%IM=[1 2 3 4 5 6 0.1 7 8 29];
m=length(IM);
K=5;
%dist代表两两之间的距离其中m*m
for i=1:m
    for j=1:m
        dist(i,j)=IM(i)-IM(j);
    end
end


disp(m)
%m=size(dist,1);                 %m为对象数，dist为两两之间的距离
distance = zeros(m,m);
num = zeros(m,m);               %distance 和num用来记录排序后的顺序，和对象编号顺序
kdistance = zeros(m,1);         %计算每个对象的kdistance
count  = zeros(m,1);            %k邻域的对象数
reachdist = zeros(m,m);         %计算两两之间的reachable-distance
lrd = zeros(m,1);
lof = zeros(m,1);
%计算k-distance
%对象的K距离
for i=1:m 
    [distance(i,:),num(i,:)]=sort(dist(i,:),'ascend');%distance按照升序对dist进行排序，num记录排序前各个dist所在位置信息
    kdistance(i)=distance(i,K+1);%获得k近邻距离，因为排序后第一个值为自身到自身的距离为0，所以k+1才是第k个最近距离
    count(i) = -1;               %自己的距离为0，要去掉自己
    for j = 1:m                  %排除有多个数据对该点有相同的k近邻距离，如果没有则count(i)=k。
        if dist(i,j)<=kdistance(i)
            count(i) = count(i)+1;%计算k距离邻域中数据点个数
        end
    end
end 
%计算可达距离
for i = 1:m
    for j=1:i-1                  %计算的是一个下三角形的矩阵
        reachdist(i,j) = max(dist(i,j),kdistance(j));
        reachdist(j,i) = reachdist(i,j);
    end
end
%计算局部可达密度
for i = 1:m
    sum_reachdist=0;
    for j=1:count(i)
        sum_reachdist=sum_reachdist+reachdist(i,num(i,j+1));
    end
    %计算每个点的lrd
    lrd(i)=count(i)/(sum_reachdist+10^(-5));
end
% 得到局部异常因子lof值
for i=1:m
    sumlrd=0;
    for j=1:count(i)
        sumlrd=sumlrd+lrd(num(i,j+1))/lrd(i);
    end
    lof(i)=sumlrd/count(i);
end

%disp(lof);
%测试时画出数据点
%{
for i=1:1:m
    if lof(i)<1.5
         plot(i,IM(i),'b.');
         hold on;
    else
         plot(i,IM(i),'ro');
         hold on
     end
end
%}
for i=1:m
    lof(i)=2/(1+exp(lof(i)));
end


end



