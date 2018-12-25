function [ th ] = mohuzhi( I )

%迭代法阈值
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

%min_I = min(min(I));
%max_I = max(max(I));
%disp(fprintf('最小值:%.5f',min_I));disp(fprintf('最大值:%.5f',max_I));
%th = floor(th);

%{
%KSW熵算法

[X, Y] = size(I);
figure ();
% 计算图像直方图
hist = imhist(I);
p = hist/(X*Y); % 各灰度概率
 
sumP = cumsum(p);
sumQ = 1-sumP;
%将256个灰度作为256个分割阈值，分别计算各阈值下的概率密度函数
c0 = zeros(3506, 3506);
c1 = zeros(3506, 3506);
for i = 6494:10000
    for j = 6494:i
        if sumP(i) > 0
            c0(i,j) = p(j)/sumP(i); %计算各个阈值下的前景概率密度函数
        else
            c0(i,j) = 0;
        end
        for k = i+1
            if sumQ(i) > 0;
                c1(i,k) = p(k)/sumQ(i); %计算各个阈值下的背景概率密度函数
            else
                c1(i,k) = 0;
            end
        end
    end 
end
 
%计算各个阈值下的前景和背景像素的累计熵
H0 = zeros(3506, 3506);
H1 = zeros(3506, 3506);
for i = 6494:10000
   for j = 6494:i
       if c0(i,j) ~=0
           H0(i,j) =  - c0(i,j).*log10(c0(i,j));  %计算各个阈值下的前景熵
       end
       for k = i+1:10000
          if c1(i,k) ~=0
              H1(i,k) =  -c1(i,k).*log10(c1(i,k));  %计算各个阈值下的背景熵
          end
       end
   end  
end
HH0 = sum(H0,2);
HH1 = sum(H1,2);
H = HH0 + HH1; 
[value, Threshold] = max(H);
 
%BW = im2bw(Imag, Threshold/10000);

%xlabel(['最大熵', num2str(Threshold)]);




%}

end

