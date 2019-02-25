function [nlabels] = LAB_KMEANS( img, img_lab, nlabels )
%将img_lab根据
%img_lab图像的lab空间值
%nlabels图像的类别分类

%聚类后的图像类别分类
%将图像分成4类
K = 6;
M = max(max(nlabels));%当前总共的类别
[r, c] = size(nlabels);

K1 = 24;%将每个lab评分拆成K1份
new_lab = zeros(M,K1*3);%将lab分成4*3，将l，a，b都平分成4分

min_l = min(min(img_lab(:,:,1)));max_l = max(max(img_lab(:,:,1)));
min_a = min(min(img_lab(:,:,2)));max_a = max(max(img_lab(:,:,2)));
min_b = min(min(img_lab(:,:,3)));max_b = max(max(img_lab(:,:,3)));
min_r = min(min(img_lab(:,:,1)));max_r = max(max(img_lab(:,:,1)));
min_g = min(min(img_lab(:,:,2)));max_g = max(max(img_lab(:,:,2)));
min_b = min(min(img_lab(:,:,3)));max_b = max(max(img_lab(:,:,3)));

for m =1:M
    
    for i=1:r
        for j=1:c
            if nlabels(i,j) == m
                
                %将L分成K1分
                for k = 1:K1
                    %if and(img_lab(i,j,1)>(max_l-min_l)/K1*(k-1), img_lab(i,j,1)<=(max_l-min_l)/K1*k)
                    if and(img_lab(i,j,1)>100/K1*(k-1), img_lab(i,j,1)<=100/K1*k)
                    %if and(img(i,j,1)>min_r+(max_r-min_r)/K1*(k-1), img(i,j,1)<=min_r+(max_r-min_r)/K1*k)
                        new_lab(m,k) = new_lab(m,k) + 1;
                        
                    end
                end
                for k=1:K1
                    %if and(img_lab(i,j,2)>(max_a-min_a)/K1*(k-1), img_lab(i,j,2)<=(max_a-min_a)/K1*k)
                    if and(img_lab(i,j,2)>255/K1*(k-1), img_lab(i,j,2)<=255/K1*k)
                    %if and(img(i,j,2)>min_g+(max_g-min_g)/K1*(k-1), img(i,j,2)<=min_g+(max_g-min_g)/K1*k)
                        new_lab(m,k+K1) = new_lab(m,k+K1) + 1;
                        
                    end
                end
                for k=1:K1
                    %if and(img_lab(i,j,3)>(max_b-min_b)/K1*(k-1), img_lab(i,j,3)<=(max_b-min_b)/K1*k)
                    if and(img_lab(i,j,3)>255/K1*(k-1), img_lab(i,j,3)<=255/K1*k)
                    %if and(img(i,j,3)>min_b+(max_b-min_b)/K1*(k-1), img(i,j,3)<=min_b+(max_b-min_b)/K1*k)
                        new_lab(m,k+2*K1) = new_lab(m,k+2*K1) + 1;
                    end
                end
               
            end
        end
    end
    
end
disp(new_lab);


idx = kmeans(new_lab, K);
for m=1:M
    for i=1:r
        for j=1:c
            if nlabels(i,j) == m
                nlabels(i,j) = idx(m);
            end
        end
    end
end

%{
random_ = new_lab(1:K, 1:K1*3);
Nlabel_pre = zeros(M,1);
Nlabel = zeros(M,1);
for index = 1:2000
    disp(fprintf('循环到第%d',index));
    for i = 1:M
        for j = 1:K
            dist(j) = sqrt(sum(power(new_lab(i,:)-random_(j,:),2)));
        end
        
        small = find(dist == min(dist));
        Nlabel(i,1) = small(1);
    end
    
    for k=1:K
        new_k = find(Nlabel(:,1)==k);%找出属于第k类别的
        for n=1:K1*3
            random_(k,n) = mean(new_lab(new_k,n));
        end
    end
    
    if Nlabel_pre == Nlabel
        disp(fprintf('%d in Nlabel_pre == Nlabel',index));
        break
    else
        Nlabel_pre = Nlabel;
    end
    disp(random_());
end
for m=1:M
    for i=1:r
        for j=1:c
            if nlabels(i,j) == m
                nlabels(i,j) = Nlabel(m);
            end
        end
    end
end

%{
%设置K个初始类的值
for m=1:M
    n_l = 0;n_a = 0; n_b = 0;n_l_num=0;n_a_num=0;n_b_num=0;
    for i=1:r
        for j=1:c
            if nlabels(i,j) == m
                n_l = n_l + img_lab(i,j,1);n_l_num = n_l_num + 1;
                n_a = n_a + img_lab(i,j,2);n_a_num = n_a_num + 1;
                n_b = n_b + img_lab(i,j,3);n_b_num = n_b_num + 1;
            end
        end
    end
    new_(m,1) = n_l/n_l_num;
    new_(m,2) = n_a/n_a_num;
    new_(m,3) = n_b/n_b_num;
    new_(m,4) = mod(m,K)+1;
end
%K个聚类的初始值new_point
new_point = zeros(K,3);l_=0;a_=0;b_=0;
for m=1:K
    for n = 1:M
        if new_(n,4) == m
            new_point(m,1) = new_point(m,1) + new_(n,1);l_ = l_ + 1;
            new_point(m,2) = new_point(m,2) + new_(n,2);a_ = a_ + 1;
            new_point(m,3) = new_point(m,3) + new_(n,3);b_ = b_ + 1;
        end
    end
    new_point(m,1) = new_point(m,1)/l_;
    new_point(m,2) = new_point(m,2)/a_;
    new_point(m,3) = new_point(m,3)/b_;
end
%设置迭代次数
for i = 1:100
    %将M个块 进行聚类
    for m = 1:M
         for k = 1:K
             dist(k) = sqrt((new_(m,1)-new_point(k,1))^2 + (new_(m,2)-new_point(k,2))^2 + (new_(m,3)-new_point(k,3))^2);
         end
         new_(m,4) = find(dist==min(dist));%将聚类结果进行规划到像素中
    end
    %将聚类中心进行更新
    for k=1:K
        l_ = find(new_(:,4)==k); 
        new_point(k,1) = mean(new_(l_,1));
        
        new_point(k,2) = mean(new_(l_,2));
        
        new_point(k,3) = mean(new_(l_,3));
    end
end
N_label = zeros(r,c);
for m=1:M
    for i =1:r
        for j=1:c
            if nlabels(i,j) == m
                N_label(i,j) = new_(m,4); 
            end 
        end
    end
end

disp(size(N_label));
end
%}
%}
