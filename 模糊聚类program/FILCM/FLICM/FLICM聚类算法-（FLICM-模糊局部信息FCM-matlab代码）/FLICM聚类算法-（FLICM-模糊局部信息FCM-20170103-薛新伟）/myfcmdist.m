function out=myfcmdist(center,data)
out=zeros(size(center,1),size(data,1));
if size(center,2)>1% data 数据为多维数据
    for k=1:size(center,1)
        out(k,:)=sqrt(sum(((data-ones(size(data,1),1)*center(k,:)).^2)'));
    end
else
    for k=1:size(center,1)
        out(k,:)=abs(center(k)-data)';
    end
end