function [Vpc,Vpe,Vxb,SA]=evaluation(data,U,cluster_n,center,I)
%计算划分系数
[m,n]=size(data);
Vpc=sum(sum(U.^2))/m;
%计算划分熵
Vpe=-sum(sum(log10(U).*U))/m;
%计算类间关联度
dist=myfcmdist(center,data);
temp1=sum(sum((U.^2).*(dist.^2)));
temp2=(repmat(center,1,cluster_n)-repmat(center',cluster_n,1)).^2;
for i=1:cluster_n
    temp2(i,i)=inf;
end
temp3=min(min(temp2));
Vxb=temp1/(m*temp3);
%计算正确分割率
load('55.mat');
c=Gr-I;
d=length(find(c==0));
SA=d/m;