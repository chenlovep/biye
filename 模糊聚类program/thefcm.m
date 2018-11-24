function [IX2,IMMM1]=thefcm(IM)
%IM是输入的源图像
%IX2是分类结果
%IM=imread('wwwlt163com200806191143.jpg');
IM=uint8(IM);
IM=IM(:,:,1);
%figure(4);
%imshow(IM);
IM=double(IM);
[maxX,maxY]=size(IM);


IMM=cat(3,IM,IM,IM);
%初始化聚类中心（4类）

cc1=70;
cc2=180;
cc3=240;
ttFcm=0;
while(ttFcm<15)
    ttFcm=ttFcm+1;
    c1=repmat(cc1,maxX,maxY);
    c2=repmat(cc2,maxX,maxY);
    c3=repmat(cc3,maxX,maxY);
    
    c=cat(3,c1,c2,c3);
    ree=repmat(0.000001,maxX,maxY);
    ree1=cat(3,ree,ree,ree);
    distance=IMM-c;
    distance=distance.*distance+ree1;
    daoshu=1./distance;
    daoshu2=daoshu(:,:,1)+daoshu(:,:,2)+daoshu(:,:,3);
    %计算隶属度u
    distance1=distance(:,:,1).*daoshu2;
    u1=1./distance1;
    distance2=distance(:,:,2).*daoshu2;
    u2=1./distance2;
    distance3=distance(:,:,3).*daoshu2;
    u3=1./distance3;
        
    %计算聚类中心z
    ccc1=sum(sum(u1.*u1.*IM))/sum(sum(u1.*u1));
    ccc2=sum(sum(u2.*u2.*IM))/sum(sum(u2.*u2));
    ccc3=sum(sum(u3.*u3.*IM))/sum(sum(u3.*u3));
        
        
        
    tmpMatrix=[abs(cc1-ccc1)/cc1,abs(cc2-ccc2)/cc2,abs(cc3-ccc3)/cc3];
    
        pp=cat(3,u1,u2,u3);
        for i=1:maxX
            for j=1:maxY
                if max(pp(i,j,:))==u1(i,j)
                    IX2(i,j)=1;
                elseif max(pp(i,j,:))==u2(i,j)
                    IX2(i,j)=2;
                else
                    IX2(i,j)=3;
                
                end
            end
        end
     %判结束条件
        if max(tmpMatrix)<0.0001
            break;
        else
            cc1=ccc1;
            cc2=ccc2;
            cc3=ccc3;
            
        end
      for i=1:maxX
            for j=1:maxY
                if IX2(i,j)==1
                    IMMM(i,j)=0.0;
                elseif IX2(i,j)==3
                    IMMM(i,j)=250.0;
                else
                    IMMM(i,j)=120.0;
                
                end
            end
        end
        
        %显示每次聚类分割结果
        
        IMMM1=uint8(IMMM);
end
%显示最终分类结果
IMMM1=uint8(IMMM1);
end

