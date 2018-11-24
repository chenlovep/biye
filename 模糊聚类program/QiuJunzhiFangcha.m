function [gauss]=QiuJunzhiFangcha(y1,y2,y3,y4,IM,maxX,maxY)

type(1:4)=0;
miyu(1:4)=0;
sita(1:4)=0;
gauss=zeros(maxX,maxY,4);
sq2Pi=sqrt(2*3.1415926);

miyu(1)=mean(y1);
miyu(2)=mean(y2);
miyu(3)=mean(y3);
miyu(4)=mean(y4);
sita(1)=std(y1);
sita(2)=std(y2);
sita(3)=std(y3);
sita(4)=std(y4);
sita2=2*(sita.*sita);

for i=1:maxX
    for j=1:maxY
        for k=1:4
            gauss(i,j,k)=exp(-(IM(i,j)-miyu(k))*(IM(i,j)-miyu(k))/(sita2(k)))/(sq2Pi*sita(k));    %¸ßË¹¸ÅÂÊ
        end
    end
end


