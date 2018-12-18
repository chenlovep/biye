function [U,center,obj_fcn]=myfcmstep(data,neipos,wid,Uold,cluster_n,expo)
[m,n]=size(neipos);
mf=Uold.^expo;%fcm中的Uki^m
center=mf*data./((ones(size(data,2),1)*sum(mf'))');%得到聚类中心
dist=myfcmdist(center,data);%计算数据和聚类中心的距离
%计算Gki
wid=repmat(wid,1,n);
for i=1:cluster_n
    U_nei=Uold(i,neipos);
    U_nei=reshape(U_nei,m,n);
    dist_nei=dist(i,neipos);
    dist_nei=reshape(dist_nei,m,n);
    G(i,:)=sum(((1-U_nei).^expo).*(dist_nei.^2)./(wid+1));
end
%计算目标函数  
obj_fcn=sum(sum((dist.^2+1*G).*mf));%%%%%%此处在G前添加了一个10作为lamuda
%计算隶属度
 tempb=(dist.^2+1*G).^(-1/(expo-1));
 U=tempb./(ones(cluster_n,1)*sum(tempb));


% U_new1 = ((dist.^2+G).^(1/(expo-1)));
% U_new2 = (ones(cluster_n, 1)*sum(U_new1.^(-1)));
% U  = 1./(U_new1.*U_new2);

