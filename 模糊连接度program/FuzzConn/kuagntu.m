function kuagntu(A)

%clc;
%A = imread('二分法结果图.jpg');

[row, col] = size(A);
for i=1:row
    for j=1:col
        if A(i,j) ~= 0
            A(i,j) = 255;
        end
    end
end

L = bwlabel(A);
num_label = zeros(1,max(max(L))+1);
num_xy = zeros(1,max(max(L))+1);
for i=1:row
    for j=1:col
        num_label(L(i,j)+1) = num_label(L(i,j)+1) + 1;
    end
end
disp(num_label);
num_able_label = [];
for i=2:length(num_label)
    if num_label(i) > 200
        num_able_label = [num_able_label i];
    end
end
%符合个数的连通域类别
disp(num_able_label);

disp(length(num_able_label));
for k = 1:length(num_able_label)
    disp(num_able_label(k));
    %disp(num_label(num_able_label(k)));
    rectangle_x=[];rectangle_y=[];
    for i =1:row
        for j=1:col
            if L(i,j) == num_able_label(k)-1
                rectangle_x = [rectangle_x i];
                rectangle_y = [rectangle_y j];
            end
        end
    end
    min_x=min(rectangle_x);max_x=max(rectangle_x);
    min_y=min(rectangle_y);max_y=max(rectangle_y);
    disp(fprintf('第%d个类别属于%d的矩形左上角x坐标:%d,y坐标:%d,长：%d，宽:%d',k,num_able_label(k),min_x,min_y, max_x-min_x,max_y-min_y));
    rectangle('Position',[min_y,min_x, max_y-min_y,max_x-min_x],'LineWidth',1,'EdgeColor','r');
end


