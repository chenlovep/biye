function A=adjacency(I,n,k1)
%function A=adjacency(I,n,k1)
% Input: image (used for size only), n=L1 distance of neighbourhood, k1=distance decline factor
%n为邻域L1距离欧氏距离，k1为距离递减因子
% Compute adjacency according to (2.8) in Udupa '96
%计算邻接
%Author: Joakim Lindblad

[r,c]=size(I);
%N为图像中所有点到所有点的邻近度函数
N=r*c;

%abs delta of column and row coordinates
dC=abs(repmat([1:c],c,1)-repmat([1:c].',1,c));
%dC为图像再C方向上的差
dR=abs(repmat([1:r],r,1)-repmat([1:r].',1,r));
%dR为图像在R方向上的差
%A为N*N的稀疏矩阵所有元素为0
A=sparse(N,N); %output matrix




for dc=0:n %for each L1 distance level
	[bi,bj]=find(dC == dc); %r*r blocks with dc<=n
	for dr=0:n-dc
        %dc和dr的和最大为1
        %其说明两者之间的距离使用的是L1，max(dc+dr)<=n
		[i,j]=find(dR == dr); %pixels within block with dr+dc<=n

		%The adjaceny
		a=1./(1+k1.*sqrt(dr.^2+dc.^2)); 


		%compute global indices and put things into A
		p=[];q=[];
		for k=1:length(bi)
			p=[p;(bi(k)-1)*r+i];
			q=[q;(bj(k)-1)*r+j];
        end
        %将p为x，q为y对应位置为repmat(a,size(q)的值，其形成最后大小为N*N的稀疏矩阵)
		A=A+sparse(p,q,repmat(a,size(q)),N,N);
	end
end
