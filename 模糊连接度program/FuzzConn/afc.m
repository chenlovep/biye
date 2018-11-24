function FC=afc(S,K)
%function FC=afc(S,K)
%
%Absolute Fuzzy Connectedness (kFOEMS) according to Saha and Udupa 2001
%S is seed image (treated as boolean)
%K is symmetric matrix of size numel(S)*numel(S) 
%绝对模糊连通性(kFOEMS)根据Saha和Udupa 2001

%S是种子图像(作为布尔值处理)

%K为大小为numel(S)*numel(S)的对称矩阵
%Author: Joakim Lindblad

% Dijkstra version
%使用Dijkstra算法进行计算模糊连接度矩阵
%Pushing values instead of pulling, fits matlab better
FC=double(S>0); %init segm = seeds

Q=find(S); %push index to seeds on queue
  %size S
while ~isempty(Q)
	fc=max(FC(Q)); %pick strongest fc in Q
	idx=find(FC(Q)==fc); %find all of same fc
    pick=Q(idx); %index in image
	Q=remove(Q,idx); %remove from Q
	%propagate affinity one layer
	f=min(fc,max(K(:,pick),[],2)); %compute fc for adjacent pixels
   
	idx=find(f>FC(:)); %find those with real change
    FC(idx)=f(idx); %update FC
	Q=[Q;idx]; %push all updated spels
end
