clear;
close all;
warning off;

I=imread('26.png');



figure;
title('原图');
imshow(I);
I=double(I);
[row,col]=size(I);
colorlevel=256;
hist=zeros(row,col);
%初始阈值thres1=80;thres2=160

%计算直方图
for i=1:row
    for j=1:col
        m=I(i,j)+1;
        hist(m)=hist(m)+1;
    end
end
hist=hist/(row*col);
miut=0;
for m=1:colorlevel
    miut=miut+(m-1)*hist(m);
end

xigmaB2=0;
for mindex=1:colorlevel
    threshold1=mindex-1;
    for thres2=threshold1+1:colorlevel-1
        threshold2=thres2;
        omega1=0;
        omega2=0;
        omega3=0;
        for m=1:threshold1-1
            omega1=omega1+hist(m);
        end
        for m=threshold1+1:threshold2
            omega2=omega2+hist(m);
        end
        omega3=1-omega1-omega2;
        miu1=0;
        miu2=0;
        miu3=0;
        for m=1:colorlevel
            if m<threshold1
                miu1=miu1+(m-1)*hist(m);
            elseif and(m<=threshold2,m>=threshold1)
                miu2=miu2+(m-1)*hist(m);
            else
                miu3=miu3+(m-1)*hist(m);
            end
        end
        miu1=miu1/omega1;
        miu2=miu2/omega2;
        miu3=miu3/omega3;
        xigmaB21=omega1*(miu1-miut)^2+omega2*(miu2-miut)^2+omega3*(miu3-miut)^2;
        xigma(mindex)=xigmaB21;
        if xigmaB21>xigmaB2
            finalt1=threshold1;
            finalt2=threshold2;
            xigmaB2=xigmaB21;
        end
    end
end
disp(finalt1);
disp(finalt2);
img=I*0;
for i=1:row
    for j=1:col
        if I(i,j)<=finalt1
            img(i,j,1)=0;
            img(i,j,2)=0;
            img(i,j,3)=0;
        elseif and(I(i,j)<=finalt2,I(i,j)>finalt1)
            img(i,j,:)=[255,0,0];
        else
            img(i,j,:)=[255,255,255];
        end
    end
end
figure;
title('Ostu算法分割');
imshow(img);