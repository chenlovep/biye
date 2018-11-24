function roulette( im,population_size,chromosome_size,thres )
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
global fitness_value;       %适应度矩阵(population_size,1)
global population;          %染色体个体(population_size,chromosome_size)
global A1;                  %A1,A2,C1,C2为染色体所对应数值，用于求解适应值（目标函数）
global A2;                  
global C1;
global C2;
%计算个体适应度
upper_bound=255;  %自变量的区间上限
second_bound=thres;
lower_bound=0;    %自变量的区间下限
%所有种群个体适应度初始化为0
for i=1:population_size
    fitness_value(i)=0;
    A1(i)=0;
    C1(i)=0;
    A2(i)=0;
    C2(i)=0;
end

for i=1:population_size
    for j=1:chromosome_size
        A1(i)=bin2dec(num2str(population(i,1:8)))';
        A2(i)=bin2dec(num2str(population(i,9:16)))';
        C1(i)=bin2dec(num2str(population(i,17:24)))';
        C2(i)=bin2dec(num2str(population(i,25:32)))';
    end
    A1(i)=C1(i)*(A1(i)/255);
    A2(i)=C1(i)+(255-C1(i)*A2(i)/255);
    C2(i)=A2(i)+(255-A2(i)*C2(i)/255);
    
    %fitness_value(i)=lower_bound+fitness_value(i)*(upper_bound-lower_bound)/(2^8-1);
    %A1(i)=lower_bound+A1(i)*(upper_bound-lower_bound)/(2^8-1);
    %C1(i)=lower_bound+C1(i)*(upper_bound-lower_bound)/(2^8-1);
    %A2(i)=lower_bound+A2(i)*(upper_bound-lower_bound)/(2^8-1);
    %C2(i)=lower_bound+C2(i)*(upper_bound-lower_bound)/(2^8-1);
    A1(i)=lower_bound+A1(i)*(second_bound-lower_bound)/(upper_bound-lower_bound);
    C1(i)=lower_bound+C1(i)*(second_bound-lower_bound)/(upper_bound-lower_bound);
    A2(i)=second_bound+A2(i)*(upper_bound-second_bound)/(upper_bound-lower_bound);
    C2(i)=second_bound+C2(i)*(upper_bound-second_bound)/(upper_bound-lower_bound);
    fitness_value(i)=-mohushang(im,A1(i),C1(i),thres);
    fitness_value(i)=fitness_value(i)-mohushang(im,A2(i),C2(i),thres);
end


clear i;
clear j;
