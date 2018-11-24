
%模糊连接度最优搜索算法
%Ua为四邻域
clear
Image(:,:,2)=double(imread('27.jpg'))./255;
Image=Image(1:2:end,1:2:end,:);
[row,col,hei]=size(Image);

thresh=0.95;
%将图像分为六层，第一层代表连接度，第二层代表原像素值，
%第三层到第六层为bool型，分别代表当前坐标的点是否指向上、下、左、右
%相邻像素，以取代指针
disp(sprintf('image size: %d x %d',size(Image,1),size(Image,2)));
imshow(Image(:,:,2))
title('1')
[SeedValue,SeedRect]=imcrop(Image(:,:,2));
SeedCoor=[floor(SeedRect(2)),ceil(SeedRect(1))];
% SeedCoor=[41,46];
Image(:,:,1)=0;%连接度初始化，全零
%树结构初始化
Image(2:SeedCoor(1),:,3)=1;
Image(SeedCoor(1):(end-1),:,4)=1;
Image(SeedCoor(1),2:SeedCoor(2),5)=1;
Image(SeedCoor(1),SeedCoor(2):(end-1),6)=1;
Image(SeedCoor(1),SeedCoor(2),1)=1;
Queue=find(Image(:,:,1));
while ~isempty(Queue)
    MaxConn=max(Image(Queue));
    MaxIdx=find(Image(Queue)==MaxConn);
    MaxIdx=MaxIdx(1);
    MaxCoor=[mod(Queue(MaxIdx),row),ceil(Queue(MaxIdx)/row)];
    Queue=remove(Queue,MaxIdx);
    if(MaxCoor(1)<1|MaxCoor(1)>size(Image,1)|MaxCoor(2)<1|MaxCoor(2)>size(Image,2))
        continue;
    end
    if(MaxConn>=thresh)
        for(I=3:6)
            [TempCoor,Conn]=calculate(Image,MaxCoor,I);
            if(Conn>Image(TempCoor(1),TempCoor(2),1))
                Image(TempCoor(1),TempCoor(2),1)=Conn;
                Image(MaxCoor(1),MaxCoor(2),I)=1;
                Queue=[Queue,TempCoor(1)+(TempCoor(2)-1)*row];
            end
        end
    else
        break;
    end
end
I_rgb=repmat(Image(:,:,2),[1,1,3]);figure(3)
image(I_rgb)
imoverlay(Image(:,:,1),Image(:,:,1)>thresh);
title(sprintf('Fuzzy connected component at level %.2f',thresh));
