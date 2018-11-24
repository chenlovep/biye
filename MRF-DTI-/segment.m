%function[color_picture]=segment(im)
function[end_picture]=segment(im)
%tmp=imread('date\26.jpg');
tmp=imread(im);
tmp=tmp(:,:,1);
IM=double(tmp);
[M,N]=size(IM);

disp(M);disp(N);
IM=IM(20:99,10:109);%控制图片的输入范围

figure(1);
imshow(uint8(IM));%对原始输入图片进行输出
%[maxX,maxY]=size(IM);%maxX，maxY为图像IM大小

init=0;
yyy=0;%迭代次数统计
times=20;

[y1,y2,y3,IX,maxX,maxY,IM]=initial(IM);%初始化分割图像，可以进行改进提高分割效果

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
    [y1,y2,y3]=FenxiGeleiZhifang(IX,IM,maxX,maxY);
    %GanChangFenbu1函数返回的StruInfo
    %StruInfo(:,:,1)=temp1,temp1为每个像素点分为类别1的概率
    %StruInfo(:,:,2)=temp2,temp2为每个像素点分为类别2的概率
    %StruInfo(:,:,3)=temp3,temp3为每个像素点分为类别3的概率
    [StruInfo]=GanChangFenbu1(maxX,maxY,IX,IM);
    %QiuJunzhiFangcha函数gauss(maxX,maxY,3)为P(X/Wi)的概率
    [gauss]=QiuJunzhiFangcha(y1,y2,y3,IM,maxX,maxY);
    %BianXiangsuLeibie2函数
    %显示figure(3)
    [IX,times,IMMRF]=BianXiangsuLeibie2(maxX,maxY,StruInfo,gauss,IX,times);
    if yyy==30%迭代次数，yyy用来统计迭代次数
        [IX,times,IMMRF]=BianXiangsuLeibie2(maxX,maxY,StruInfo,gauss,IX,times);
        break;
    end
end
%用模糊C均值方法(FCM)进行图像分割
[IX2,IMMM]=thefcm(IM);
%对原图像周围进行填充0
IM2=zeros(maxX+2,maxY+2);



for i=1:maxX
    for j=1:maxY
        IM2(i+1,j+1)=IM(i,j);
    end
end
[N_maxX,N_maxY]=size(IM2);
LOF=zeros(maxX,maxY);
disp(N_maxX);disp(N_maxY);
disp(maxX);
disp(maxY);
COUNT=0;
for i=1:maxX
    for j=1:maxY
        X=IM2(i:i+2,j:j+2);
        disp(COUNT);
        COUNT=COUNT+1;
        [lof]=aerfa(X);
        LOF(i,j)=lof(5);
    end
end

end_picture1=LOF.*IMMM;
end_picture2=(1-LOF).*im2double(IMMRF);
end_picture=end_picture1+end_picture2;

%Picture=uint8(end_picture);
%disp(Picture);
%figure(7);
%imshow(Picture);
%color_picture=color(IMMM);


