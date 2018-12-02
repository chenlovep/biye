function FC=afc(S,K)
%function FC=afc(S,K)
%S(128,128)
%K(128*128,128*128)每个像素点的相对其他像素点的亲和度
%Absolute Fuzzy Conn看，ectedness (kFOEMS) according to Saha and Udupa 2001
%S is seed image (treated as boolean)
%K is symmetric matrix of size numel(S)*numel(S) 
%绝对模糊连通性(kFOEMS)根据Saha和Udupa 2001

%S是种子图像(作为布尔值处理)

%K为大小为numel(S)*numel(S)的对称矩阵-
%Author: Joakim Lindblad

% Dijkstra version
%使用Dijkstra算法进行计算模糊连接度矩阵
%Pushing values instead of pulling, fits matlab better
FC=double(S>0); %init segm = seeds
%FC将种子点设为1，其余非种子点为0
Q=find(S); %push index to seeds on queue
%将种子点进Q中
  %size S
%S(128,128);K(128*128,128*128)
%FC(128,128)
c=0;
while ~isempty(Q)
	fc=max(FC(Q)); %pick strongest fc in Q       %fc为像素模糊连接度最大的像素集合
    
    idx=find(FC(Q)==fc); %find all of same fc    %确定像素在FC中的位置
    pick=Q(idx); %index in image                 %将Q中对应像素挑选出来
    Q=remove(Q,idx); %remove from Q
	%propagate affinity one layer
	f=min(fc,max(K(:,pick),[],2)); %compute fc for adjacent pixels
    
    %找出集合fc中像素重叠邻域点的最优路径
	idx=find(f>FC(:)); %find those with real change
    disp(length(idx));
    c=c+length(idx);
    FC(idx)=f(idx); %update FC
	Q=[Q;idx]; %push all updated spels
end
disp(c);