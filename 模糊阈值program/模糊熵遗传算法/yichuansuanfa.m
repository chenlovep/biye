function [ H,A1,C1,A2,C2 ] = yichuansuanfa( im )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明


elitism=false;                 %精英选择
population_size=100;           %种群大小
ger=200;                       %迭代次数
chromosome_size=32;            %染色体长度(4个未知数，由8位二进制表示)
cross_rate=0.6;                %交叉概率
mutate_rate=0.2;               %变异概率
%H为其目标函数
global G;                      %当前迭代次数
global population;             %适应函数（population_size,chromosome_size）
global fitness_value;          %当前代适应度矩阵 (population_size,1)
global best_fitness;           %历代最佳适应值   (1,chromosome_size)
global fitness_average;        %历代平均适应值矩阵 
global best_individual;        %历代最佳个体
global best_generation;        %最佳个体出现代
upper_bound=255;
lower_bound=0;

fitness_average=zeros(ger,1);            
fitness_value(population_size)=0;



figure(1);
title('原始图像');
imshow(im);

best_fitness=0;
best_generation=0;

%生成初始随机种群
init_population(population_size,chromosome_size);
disp(sprintf('Number of generations:%d',ger));
disp(sprintf('Population size:%d',population_size));
disp(sprintf('Crossover probability:%.3f',cross_rate));
disp(sprintf('Mutation probability:%.3f',mutate_rate));

for G=1:ger
    disp(G);
    %自适应度函数
    roulette(im,population_size,chromosome_size);
    %进行选择
    xuanze(population_size,chromosome_size);
    %轮盘选择
    lunpan(population_size,chromosome_size,elitism);
    %交叉处理
    jiaocha(population_size,chromosome_size,cross_rate);
    %变异
    bianyi(population_size,chromosome_size,mutate_rate);

end



m=best_individual;%最佳个体
n=best_fitness;%最佳适应度
p=best_generation;%最佳个体出现时的迭代次数


%获得最佳个体变量值
A1=bin2dec(num2str(m(1:8)))';
C1=bin2dec(num2str(m(9:16)))';
A2=bin2dec(num2str(m(17:24)))';
C2=bin2dec(num2str(m(25:32)))';
    %{
    if m(j)==1
        if j<=8
            A1=A1+2^(j-1);
        elseif and(j<=16,j>8)
            C1=C1+2^(j-8-1);
        elseif and(j>16,j<=24)
            A2=A2+2^(j-16-1);
        else
            C2=C2+2^(j-24-1);
        end
    end
    %}
H=mohushang(im,A1,C1,A2,C2);        
end

