
A0=imread('date\32.jpg');%读取图像
seed=[1,2];%选择起始位置
thresh=15;%相似性选择阈值
A=A0;%灰度化
A=imadjust(A,[min(min(double(A)))/255,max(max(double(A)))/255],[]);
A=double(A);%将图像灰度化
B=A;
[r,c]=size(B);%r为行数，c为列
n=r*c;%计算图像包含点的个数
pixel_seed=A(seed(1),seed(2));%原图起始点灰度值
q=[seed(1),seed(2)];%q用来装载起始位置
top=1;%循环判断flag
M=zeros(r,c);%建立一个与原图大小一样的矩阵
M(seed(1),seed(2))=1;%将起始点赋为1，其余为0
count=1;%计数器
 
while top~=0 %循环结束条件
    r1=q(1,1);%起始点行位置
    c1=q(1,2);%起始点列位置
    p=A(r1,c1);%起始点灰度值
    dge=0;
    for i=-1:1%周围点循环判断
        for j=-1:1
            
            if r1+i<=r & r1+i>0 & c1+j<=c & c1+j>0%保证在点周围范围内
                if abs(A(r1+i,c1+j)-p)<=thresh & M(r1+i,c1+j)~=1
                    top=top+1;%满足判定条件则top+1，top为多少，则q的行数有多少
                    q(top,:)=[r1+i,c1+j];%将满足判定条件的周围点位置赋予q，q记载了满足判定的每一外点
                    M(r1+i,c1+j)=1;%满足判定条件将M中相对应的点赋1
                    count=count+1;%统计满足条件的点个数，其实与top此时的值一样
                    B(r1+i,c1+j)=1;%满足判定条件将B中相对应点赋值1
                end
                
                if M(r1+i,c1+j)==0;%如果M中相对应的值为0，将dge赋值为1，也就是说这几个点不满足条件
                    dge=1;
                end
                
            else
                dge=1;%在图像外将dge赋值为1
            end
        end
    end
    %此时对周围几点判断完毕，在点在图像外或不满足判定条件则将dge赋为1，满足条件dge为0
    if dge~=1
        B(r1,c1)=A(seed(1),seed(2));%将原图起始位置赋予B
    end
    
    if count>=n%如果满足判定条件的点个数大于等于n
        top=1;
    end
    
    q=q(2:top,:);
    top=top-1;
end
subplot(121),imshow(A,[]);
subplot(122),imshow(B,[]);