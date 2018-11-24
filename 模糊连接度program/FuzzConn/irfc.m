function Sout=irfc(S,K)
%function Sout=irfc(S,K)
%
%Iterative Relative Fuzzy Connectedness (kIRMOFC) according to Ciesielski et al 2007
%S is seed image with n classes starting from 1
%K is symmetric matrix of size numel(S)*numel(S) 
%Sout is segmentation into same classes
%
%Author: Joakim Lindblad

n=max(S(:)); %Classes
Sout=zeros(size(S)); %Output image

for i=1:n %For each class
	disp(sprintf('Class %d',i));
	Si=(S==i); %Get seed
	W=(S>0 & S~=i); %All other seeds

	Fi=zeros(size(S)); %Will be output

	FCs=afc(Si,K);
	Ks=K;
	count=0;
	while true
		FCw=afc(W,Ks);
		idx=find(Fi==0 & FCs>FCw); %not set and FCs stronger than FCw
		if (isempty(idx)) break; end %no change, stop
		Fi(idx)=1; %set
		Ks(idx,:)=0; %no affinity for W inside fs
		Ks(:,idx)=0;
   	count=count+1;
	end

	disp(sprintf('%d iterations',count));

	Sout(find(Fi))=i; %Write class in output image
end
