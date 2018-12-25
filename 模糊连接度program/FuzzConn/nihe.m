function [a, b, c] = nihe( x, y, k )

if nargin == 2%直线拟合
    %直线拟合
    %原始数据          
    [m, n] = size(x);
    x2=sum(x.^2);       % 求Σ(xi^2)
    x1=sum(x);          % 求Σ(xi)
    x1y1=sum(x.*y');     % 求Σ(xi*yi)
    y1=sum(y');          % 求Σ(yi)
    a=(n*x1y1-x1*y1)/(n*x2-x1*x1);      %解出直线斜率b=(y1-a*x1)/n
    b=(y1-a*x1)/n;                      %解出直线截距
    c=0;
end
if nargin == 3%曲线拟合
[a,b,c] = polyfit(x, y',k);

end

