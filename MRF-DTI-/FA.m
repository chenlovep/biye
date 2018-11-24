IM=imread('date/33.jpg');
[maxX,maxY]=size(IM);
disp(log(10))
figure(1);
imshow(uint8(IM));
IM1=zeros(maxX,maxY+2);
for i=1:maxX
    for j=1:maxY
        IM1(i,j+1)=IM(i,j);
    end
end
%(0.707,0,0.707)梯度加权
IX1=zeros(maxX,maxY);
for i=1:maxX
    for j=1:maxY
        IX1(i,j)=IM1(i,j)*0.707+IM1(i,j+2)*0.707;
    end
end

%（-0.707，0,0.707）梯度加权
IX2=zeros(maxX,maxY);
for i=1:maxX
    for j=1:maxY
        IX2(i,j)=IM1(i,j)*-0.707+IM1(i,j+2)*0.707;
    end
end

%（0,0.707,0.707）梯度加权
IX3=zeros(maxX,maxY);
for i=1:maxX
    for j=1:maxY
        IX3(i,j)=IM1(i,j+1)*0.707+IM1(i,j+2)*0.707;
    end
end

%（0，-0.707，0.707）梯度加权
IX4=zeros(maxX,maxY);
for i=1:maxX
    for j=1:maxY
        IX4(i,j)=IM1(i,j+1)*-0.707+IM1(i,j+2)*0.707;
    end
end

%（0.707，0.707，0）梯度加权
IX5=zeros(maxX,maxY);
for i=1:maxX
    for j=1:maxY
        IX5(i,j)=IM1(i,j)*0.707+IM1(i,j+1)*0.707;
    end
end

%（-0.707，0.707，0）梯度加权
IX6=zeros(maxX,maxY);
for i=1:maxX
    for j=1:maxY
        IX6(i,j)=IM1(i,j)*-0.707+IM1(i,j+1)*0.707;
    end
end


IX=zeros(maxX-2,maxY-2);IX_md=zeros(maxX-2,maxY-2);
for i=2:maxX-1
    for j=2:maxY-1
        A=double(IM(i-1:i+1,j-1:j+1));
        B=double(IX1(i-1:i+1,j-1:j+1));
        C=double(IX2(i-1:i+1,j-1:j+1));
        D=double(IX3(i-1:i+1,j-1:j+1));
        E=double(IX4(i-1:i+1,j-1:j+1));
        F=double(IX5(i-1:i+1,j-1:j+1));
        G=double(IX6(i-1:i+1,j-1:j+1));
        y_1=log((A+eps)./(B+eps));
        y_2=log((A+eps)./(C+eps));
        y_3=log((A+eps)./(D+eps));
        y_4=log((A+eps)./(E+eps));
        y_5=log((A+eps)./(F+eps));
        y_6=log((A+eps)./(G+eps));
        y1=y_1.*[0.5,0,0.5;0,-0.5,0;0.5,0,0.5];
        y2=y_2.*[0.5,0,0.5;0,-0.5,0;-0.5,0,0.5];
        y3=y_3.*[-0.5,0,0;0,0.5,0.5;0,0.5,0.5];
        y4=y_4.*[-0.5,0,0;0,0.5,-0.5;0,-0.5,0.5];
        y5=y_5.*[0.5,0.5,0;0.5,0.5,0;0,0,-0.5];
        y6=y_6.*[0.5,-0.5,0;-0.5,0.5,0;0,0,-0.5];
        Y=(y1+y2+y3+y4+y5+y6)*50;
        [x,MD]=lamuta(Y);
        IX_md(i-1,j-1)=MD;
        IX(i-1,j-1)=x;
        
    
    end
end



figure(2);
imshow(uint8(IX1));
figure(3);
imshow(uint8(IX2));
figure(4);
imshow(uint8(IX3));
figure(5);
imshow(uint8(IX4));
figure(6);
imshow(uint8(IX5));
figure(7);
imshow(uint8(IX6));
figure(8);
imshow(IX)
figure(9);
imshow(IX_md)