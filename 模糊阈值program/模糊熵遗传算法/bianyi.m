function  bianyi( population_size,chromosome_size,mutate_rate )
%UNTITLED8 此处显示有关此函数的摘要
%遗传算法的变异部分

global population;
%找到需要变异的群体
for i=1:population_size
    by=find(rand(1,population_size)<mutate_rate);
end
%将变异的群体中找出3个变异位置U<V<W,将（U,V）摆在W之后位置
for i=1:length(by)
        bw=sort(mod(floor(100*rand(1,3)),chromosome_size)+1);
        population(by(i),:)=population(by(i),[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:chromosome_size]);
end

clear i;
clear mutate_position;

