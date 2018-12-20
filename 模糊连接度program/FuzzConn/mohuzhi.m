function [ th ] = mohuzhi( I )
%计算图像的灰度最小值和最大值
tmin = min(I(:));
tmax = max(I(:));
%设定初始阈值
th = (tmin+tmax)/2;
%定义开关变量，用于控制循环次数
ok = true;
%迭代法计算阈值
while ok
    g1 = I >= th;
    g2 = I < th;
    u1 = mean(I(g1));
    u2 = mean(I(g2));
    thnew = (u1+u2)/2;
    %设定两次阈值的比较当满足小于1时停止循环
    ok = abs(th - thnew) >= 1;
    th = thnew;
end
disp(th)
%th = floor(th);
end

