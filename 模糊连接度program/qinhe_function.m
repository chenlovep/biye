function K = qinhe_function( img, lishudu )
%图像亲和度处理
%{
[row,col] = size(img);
img = reshape(img, [row*col,1]);
disp(size(img));
disp(size(repmat(img,1,row*col)));
I = abs(repmat(img, 1, row*col)-repmat(img',row*col, 1));
Wjun_ = mean(mean(I));
Wvar_ = (std2(I))^2;
disp(Wjun_);
disp(Wvar_);
disp(size(exp(double(-(I.*I)./(2*(Wjun_+Wvar_)^2)))));
U1 = exp(double(-(I.*I)./(2*(Wjun_+Wvar_)^2)));
disp(size(U1));
%}
k2=2;
img = double(img);
[i,j,a]=find(lishudu); %get adjacencies

K=sparse(i,j,a./(1+k2.*abs(img(i)-img(j))),size(lishudu,1),size(lishudu,2));
end

