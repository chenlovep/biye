function out = distfcm(center, data)
% 计算样本点距离聚类中心的距离
% 输入：
%   center     ---- 聚类中心
%   data       ---- 样本点
% 输出：
%   out        ---- 距离
out = zeros(size(center, 1), size(data, 1));
for k = 1:size(center, 1), % 对每一个聚类中心
    % 每一次循环求得所有样本点到一个聚类中心的距离
    out(k, :) = sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)',1));
     %out(k, :) = log(max( data./(ones(size(data,1),1)*center(k,:)),(ones(size(data,1),1)*center(k,:))./data ));
%      d = max( data./(ones(size(data,1),1)*center(k,:)),(ones(size(data,1),1)*center(k,:))./data );
%      out(k, :) = exp(d-1)-1;
end