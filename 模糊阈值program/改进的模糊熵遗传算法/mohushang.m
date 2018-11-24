function [ H ] = mohushang( im,a,c,thres )
%UNTITLED3 此处显示有关此函数的摘要
%模糊上计算
%{
[row,col]=size(im);
b1=(a1+c1)/2;b2=(a2+c2)/2;
Ud=zeros(255,1);
Ug=zeros(255,1);
Ub=zeros(255,1);
for i=0:255
        if i<a1
            Ud(i+1,1)=1;
            Ug(i+1,1)=0;
            Ub(i+1,1)=0;
        elseif and(i<b1,i>a1)
            Ud(i+1,1)=1-2*((im(i)-a1)/(c1-a1))^2;
            Ug(i+1,1)=2*((im(i)-a1)/(c1-a1))^2;
            Ub(i+1,1)=0;
        elseif and(i<c1,i>b1)
            Ud(i+1,1)=2*((im(i)-c1)/(c1-a1))^2;
            Ug(i+1,1)=1-2*((im(i)-c1)/(c1-a1))^2;
            Ub(i+1,1)=0;
        elseif and((i)>c1,i<a2)
            Ud(i+1,1)=0;
            Ug(i+1,1)=1;
            Ub(i+1,1)=0;
        elseif and(i>a2,i<b2)
            Ud(i+1,1)=0;
            Ug(i+1,1)=1-2*((im(i)-a2)/(c2-a2))^2;
            Ub(i+1,1)=2*((im(i)-a2)/(c2-a2))^2;
        elseif and(i>b2,i<c2)
            Ud(i+1,1)=0;
            Ug(i+1,1)=2*((im(i)-c2)/(c2-a2))^2;
            Ub(i+1,1)=1-2*((im(i)-c2)/(c2-a2))^2;
        else
            Ud(i+1,1)=0;
            Ug(i+1,1)=0;
            Ub(i+1,1)=1;
        end
end
h=zeros(255,1);
for i=1:row
    for j=1:col
        h(im(i,j)+1,1)=h(im(i,j)+1,1)+1;
    end
end
h=h/(row*col);%图像直方图函数
Pd=0;Pg=0;Pb=0;
for i=1:255
    Pd=Pd+h(i,1)*Ud(i);
    Pg=Pg+h(i,1)*Ug(i);
    Pb=Pb+h(i,1)*Ub(i);
end
Hd=0;Hg=0;Hb=0;
for i=1:255
    Hd=Hd+(h(i)*Ud(i)/Pd)*exp(1-h(i)*Ud(i)/Pd);
    Hg=Hg+(h(i)*Ug(i)/Pg)*exp(1-h(i)*Ug(i)/Pg);
    Hb=Hb+(h(i)*Ub(i)/Pb)*exp(1-h(i)*Ub(i)/Pb);
end
H=Hd+Hg+Hb;
end
%}
[row,col]=size(im);
b=(a+c)/2;
U=zeros(255,1);
Ud=zeros(255,1);
Ug=zeros(255,1);
Ub=zeros(255,1);
if c<=thres
    for i=0:fix(thres)
        if i<a
            U(i+1,1)=1;
            Ug(i+1,1)=0;
            Ub(i+1,1)=0;
        elseif and(i<b,i>a)
            Ud(i+1,1)=1-2*((im(i)-a)/(c-a))^2;
            Ug(i+1,1)=2*((im(i)-a)/(c-a))^2;
            Ub(i+1,1)=0;
        elseif and(i>=b,i<c)
            Ud(i+1,1)=2*((im(i)-c)/(c-a))^2;
            Ug(i+1,1)=1-2*((im(i)-c)/(c-a))^2;
            Ub(i+1,1)=0;
        else
            Ud(i+1,1)=0;
            Ug(i+1,1)=1;
            Ub(i+1,1)=0;
        end
    end

else
    for i=round(thres):255
        if i<a
            Ud(i+1,1)=0;
            Ug(i+1,1)=1;
            Ub(i+1,1)=0;
        elseif and(i>a,i<b)
            Ud(i+1,1)=0;
            Ug(i+1,1)=1-2*((im(i)-a)/(c-a))^2;
            Ub(i+1,1)=2*((im(i)-a)/(c-a))^2;
        elseif and(i>b,i<c)
            Ud(i+1,1)=0;
            Ug(i+1,1)=2*((im(i)-c)/(c-a))^2;
            Ub(i+1,1)=1-2*((im(i)-c)/(c-a))^2;
        else
            Ud(i+1,1)=0;
            Ug(i+1,1)=0;
            Ub(i+1,1)=1;
        end
    end
end
h=zeros(255,1);
for i=1:row
    for j=1:col
        h(im(i,j)+1,1)=h(im(i,j)+1,1)+1;
    end
end
h=h/(row*col);%图像直方图函数
Pd=0;Pg=0;Pb=0;
for i=1:255
    Pd=Pd+h(i,1)*Ud(i);
    Pg=Pg+h(i,1)*Ug(i);
    Pb=Pb+h(i,1)*Ub(i);
end
Hd=0;Hg=0;Hb=0;
for i=1:255
    Hd=Hd+(h(i)*Ud(i)/Pd)*exp(1-h(i)*Ud(i)/Pd);
    Hg=Hg+(h(i)*Ug(i)/Pg)*exp(1-h(i)*Ug(i)/Pg);
    Hb=Hb+(h(i)*Ub(i)/Pb)*exp(1-h(i)*Ub(i)/Pb);
end
H=Hd+Hg+Hb;
end
