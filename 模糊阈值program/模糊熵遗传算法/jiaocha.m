function jiaocha( population_size,chromosome_size,cross_rate )
%遗传算法的交叉部分
global population;
for i=1:2:population_size
    %rand<交叉概率，对两个个体的染色体串进行交叉操作
    if rand<cross_rate               %在概率小于交叉概率表的情况下进行交叉
        cross_poition=round(rand*chromosome_size);
        if (cross_poition==0 || cross_poition==1)
            continue;
        end
        %对cross_position及之后的二进制进行交换
        for j=cross_poition:chromosome_size
            temp=population(i,j);
            population(i,j)=population(i+1,j);
            population(i+1,j)=temp;
        end
    end
end

clear i;
clear j;
clear temp;
clear cross_position;

