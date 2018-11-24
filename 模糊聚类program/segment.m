%function[color_picture]=segment(im)
%function[end_picture]=segment(im)
%tmp=imread('date\26.jpg');
tmp=imread('27.jpg');
%添加噪声
figure(1);
imshow(tmp);
tmp=add_noise(tmp);
figure(2);
imshow(tmp);

tmp=tmp(:,:,1);
IM=double(tmp);
[M,N]=size(IM);

%disp(M);disp(N);
IM=IM(20:99,10:109);%控制图片的输入范围

figure(3);
imshow(uint8(IM));%对原始输入图片进行输出
tic;
[r,c]=size(IM);


%模糊C均值
%[IX2,IMMM]=thefcm(IM);
%用模糊C均值方法(FCM)进行图像分割

data=zeros(r*c,1);
for i=1:r
    for j=1:c
        data((i-1)*c+j)=double(IM(i,j));
    end
end
cluster_n=4;
[center,u,obj_fcn]=FCM(data,cluster_n);

%来对输出的类别进行准确分类，否则会出现每次分类结果像素不确定现象
[CENTER,index_center]=sort(center);
U=zeros(size(u));
for i=1:cluster_n
    U(i,:)=u(index_center(i),:);
end


%计算分割系数Vpc
Vpc=0;
%计算分割熵
Vpe=0;
[Ucluster_n,Udata_n]=size(U);
for i=1:Ucluster_n
    for j=1:Udata_n
        Vpc=Vpc+(U(i,j)^2);
        Vpe=Vpe+U(i,j)*log(U(i,j));
    end
end
Vpc=Vpc/Udata_n;
Vpe=-Vpe/Udata_n;
disp('-----------分割系数Vpc-------------');
disp(Vpc);
disp('-----------分割熵Vpe---------------');
disp(Vpe);
img_seg=IM*0;

for i=1:r
    for j=1:c
        temp=U(:,(i-1)*c+j);
        [a,b]=max(temp);
        img_seg(i,j)=b;
        if img_seg(i,j)==1
            IMMM(i,j)=0;
        elseif img_seg(i,j)==2
            IMMM(i,j)=80;
        elseif img_seg(i,j)==3
            IMMM(i,j)=80;
        else
            IMMM(i,j)=250;
        end
    end
end

figure(4);
imshow(uint8(IMMM));


%[maxX,maxY]=size(IM);%maxX，maxY为图像IM大小

init=0;
yyy=0;%迭代次数统计
times=20;

[y1,y2,y3,y4,IX,maxX,maxY,IM]=initial(IM);%初始化分割图像，可以进行改进提高分割效果

%初始figure(2)
%maxX，maxY为图像大小
%y1,y2,y3为分成的3类中的元素矩阵集合
%y1为像素值最低的类别，y2为像素值第二低的类别，y3位像素值最高的类别
%IX为初始标签矩阵 

while(1)
    %timesTmp=times;
    %利用yyy进行迭代
    yyy=yyy+1;
    %FenxiGeleiZhifang函数用来统计每个类别中的个数以及对应元素值
    [y1,y2,y3,y4]=FenxiGeleiZhifang(IX,IM,maxX,maxY);
    %GanChangFenbu1函数返回的StruInfo
    %StruInfo(:,:,1)=temp1,temp1为每个像素点分为类别1的概率
    %StruInfo(:,:,2)=temp2,temp2为每个像素点分为类别2的概率
    %StruInfo(:,:,3)=temp3,temp3为每个像素点分为类别3的概率
    %StruInfo(:,:,4)=temp4,temp4为每个像素点分为类别4的概率
    [StruInfo]=GanChangFenbu1(maxX,maxY,IX,IM);
    %QiuJunzhiFangcha函数gauss(maxX,maxY,3)为P(X/Wi)的概率
    [gauss]=QiuJunzhiFangcha(y1,y2,y3,y4,IM,maxX,maxY);
    %BianXiangsuLeibie2函数
    %显示figure(3)
    [IX,times,IMMRF]=BianXiangsuLeibie2(maxX,maxY,StruInfo,gauss,IX,times);
    if yyy==30%迭代次数，yyy用来统计迭代次数
        [IX,times,IMMRF]=BianXiangsuLeibie2(maxX,maxY,StruInfo,gauss,IX,times);
        break;
    end
end
IMMRF=uint8(IMMRF);
figure(5);
imshow(IMMRF);
CStruInfo=zeros(cluster_n,r*c);


%对原图像周围进行填充0
IM2=zeros(maxX+2,maxY+2);
%figure(8)
%imshow(IMMM)

for i=1:maxX
    for j=1:maxY
        IM2(i+1,j+1)=IM(i,j);
    end
end
[N_maxX,N_maxY]=size(IM2);
LOF=zeros(maxX,maxY);
COUNT=0;
for i=1:maxX
    for j=1:maxY
        X=IM2(i:i+2,j:j+2);
        COUNT=COUNT+1;
        [lof]=aerfa(X);
        LOF(i,j)=lof(5);
    end
end

end_picture1=LOF.*im2double(IMMM);
end_picture2=(1-LOF).*im2double(IMMRF);
end_picture=(end_picture1+end_picture2);
end_picture=end_picture./max(max(end_picture));
Picture=uint8(end_picture*255);
figure(6);
imshow(Picture);


%计算整个算法的Vpc和Vpe
STR=zeros(size(U));
for i=1:r
    for j=1:c
        for k=1:cluster_n
            STR(k,(i-1)*c+j)=StruInfo(i,j,k);
        end
    end
end
lof=zeros(1,r*c);
disp(r);
disp(c);
for i=1:r
    for j=1:c
        lof((i-1)*c+j)=LOF(i,j);
    end
end
lof=repmat(lof,cluster_n,1);
V=(lof.*U+(1-lof).*STR);
%计算分割系数Vpc
vpc=0;
%计算分割熵
vpe=0;
[Ucluster_n,Udata_n]=size(U);
for i=1:Ucluster_n
    for j=1:Udata_n
        vpc=vpc+(V(i,j)^2);
        vpe=vpe+V(i,j)*log(V(i,j));
    end
end

vpc=vpc/Udata_n;
vpe=-vpe/Udata_n;
disp('-----------分割系数Vpc-------------');
disp(vpc);
disp('-----------分割熵Vpe---------------');
disp(vpe);




SA=zhengquelv(Picture);
disp(SA);
toc;
%color_picture=color(IMMM);


