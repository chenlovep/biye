function [StruInfo]=GanChangFenbu1(maxX,maxY,IX,IM)

temp=zeros(maxX,maxY);
temp1=zeros(maxX,maxY);
temp2=zeros(maxX,maxY);
temp3=zeros(maxX,maxY);
temp4=zeros(maxX,maxY);

beita=1;
myu=zeros(maxX,maxY);
xigmaMyu=zeros(maxX,maxY);

for i=1:maxX
    for j=1:maxY
        %i==1,j==1为图像的左上角的第一个像素点
        if and(i==1,j==1)
            %对3种不同的类别
            for m=1:4
                %deta函数当两个参数相等返回1，不相同则返回0
                %IX为当前的类别，m为预期类别
                temp(i,j)=temp(i,j)+deta(m,IX(i,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                %temp(i,j)=U(x)
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                %xigmaMyu为Z
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif and(i==1,j==maxY)
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif and(i==maxX,j==1)
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif and(i==maxX,j==maxY)
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif i==1
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif j==1
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif i==maxX
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        elseif j==maxY
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);
                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        else
            for m=1:4
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j-1))-1;      %2*u(x);u(x)=deta(xi-xj)-1,xi取三类
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i-1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j+1))-1;      %2*u(x);u(x)=deta(xi-xj)-1,xi取三类
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j-1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i+1,j+1))-1;
                temp(i,j)=temp(i,j)+deta(m,IX(i,j))-1;
                xigmaMyu(i,j)=exp(beita*temp(i,j))+xigmaMyu(i,j);

                if m==1
                    temp1(i,j)=temp(i,j);
                end
                if m==2
                    temp2(i,j)=temp(i,j);
                end
                if m==3
                    temp3(i,j)=temp(i,j);
                end
                if m==4
                    temp4(i,j)=temp(i,j);
                end
                temp(i,j)=0;
            end
        end
    end
end

temp1=exp(beita*temp1);
temp1=temp1./xigmaMyu;
%temp1为每个像素点的P(X=1)的概率
temp2=exp(beita*temp2);
temp2=temp2./xigmaMyu;
%temp2为每个像素点的P(X=2)的概率
temp3=exp(beita*temp3);
temp3=temp3./xigmaMyu;
%temp3为每个像素点的P(X=3)的概率
temp4=exp(beita*temp4);
temp4=temp4./xigmaMyu;
%temp4为每个像素点的P(X=4)的概率
StruInfo=cat(3,temp1,temp2,temp3,temp4);
%cat(3,A,B)
%StruInfo(:,:,1)=temp1
%StruInfo(:,:,2)=temp2
%StruInfo(:,:,3)=temp3
%StruInfo(:,:,4)=temp4
