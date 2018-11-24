function  xuanze(population_size,chromosome_size )
%   此处显示详细说明
global fitness_value;
global fitness_sum;
global fitness_average;
global best_fitness;
global best_generation;
global best_individual;
global population;
global G;

for i=1:population_size
    fitness_sum(i)=0;
end

min_index=1;
temp=1;
temp_chromosome(chromosome_size)=0;

%便利种群
%冒泡排序
%最后population(i)的适应度随i递增而递增，population(population_size)最大
for i=1:population_size-1
    min_index=i;
    for j=i+1:population_size
        if fitness_value(j) < fitness_value(min_index)
            min_index=j;
        end
    end
    
    if min_index~=i
        %交换fitness_value(i)和fitness_value(min_index)
        temp=fitness_value(i);
        fitness_value(i)=fitness_value(min_index);
        fitness_value(min_index)=temp;
        %fitness_value(i)的适应度在[i,population_size]最大
        %交换population(i)和population(min_index)的染色体串
        for k=1:chromosome_size
            temp_chromosome(k)=population(i,k);
            population(i,k)=population(min_index,k);
            population(min_index,k)=temp_chromosome(k);
        end
    end
end
%此时population递减排列
%fitness_sum(i)为前i个个体的适应度之和
for i=1:population_size
    if i==1
        fitness_sum(i) = fitness_sum(i) + fitness_value(i);
    else
        fitness_sum(i) = fitness_sum(i-1) + fitness_value(i);
    end
end

%fitness_average(G)=第G次迭代个体的平均是适应度
fitness_average(G) = fitness_sum(population_size)/population_size;

%disp(fitness_value);
%此时fitness_value经过递减排序后，fitness_value(population_size)为最小值
%经过迭代将每次迭代后最小值递归给best_fitness
%更新最大适应度和对应的迭代次数，保存最佳个体
if -fitness_value(population_size) > best_fitness
    best_fitness=-fitness_value(population_size);
    best_generation=G;
    for j=1:chromosome_size
        best_individual(j)=population(population_size,j);
    end
  
end
%disp(best_fitness);
%disp(best_generation);
%disp(best_individual);
clear i;
clear j;
clear k;
clear min_index;
clear temp;


