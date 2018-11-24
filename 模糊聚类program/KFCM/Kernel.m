function d=Kernel(data, center, segma2)
%segma2      参数反差
%d           kernel距离
d=zeros(size(center,1),size(data,1));
data = data';
for k=1:size(center,1),
    %每一次循环求得所有样本点到一个聚类中心的距离
    d(k,:)=exp(-(data-center(k)).^2/segma2);
end
d=2*(1-d);
end