function [lishu] = lishudu_function(img)
[row, col] = size(img);
k  =0.1;
n = 1;
%disp(fprintf('图像尺寸大小为%d,%d',row,col));
lishu = sparse(row*col, row*col);
drow = abs(repmat([1:row], row, 1) - repmat([1:row]', 1, row));
dcol = abs(repmat([1:col], col, 1) - repmat([1:col]', 1, col));

for dr = 0:n
    %行差
    [dri, drj] = find(drow == dr);
    
    for dc = 0:n-dr  %将行差和列差之和小于等于n
        %将两个点符合条件的坐标进行记录，(dri,dci),(drj,dcj)
        %列差
        [dci, dcj] = find(dcol == dc);
        
        %隶属度值
        a = 1/(1+k*sqrt(dr^2+dc^2));
        p = [];q=[];
        for i =1:length(dri)
             p = [p;(dri(i)-1)*col+dci];%将符合条件的像素点坐标进行放进row*col,row*col大小的矩阵中
             q = [q;(drj(i)-1)*row+dcj];%(dri,dci)为第一个点，(dri(i) -1)*col+dci将坐标进行拉伸一维处理，q，p为两个点的拉伸坐标
        end
        lishu = lishu + sparse(p,q,repmat(a,size(q)),row*col, row*col);
    end
end


end