function out = distfcm(center, data)
%计算样本点距离聚类中心的距离
% center 聚类中心
% data 样本点
%   此处显示详细说明
% out   距离
out = zeros(size(center,1),size(data,1));
for k = 1:size(center,1),
    %每一次进行一个聚类中心距离的计算
    out(k,:) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
end
end
