function init_population( population_size,chromosome_size )
%初始化染色体种群 ，32为2进制
global population
population=zeros(population_size,chromosome_size);
for i=1:population_size
    for j=1:chromosome_size
        population(i,j)=round(rand);%将所有数据初始化为0或1 ，二进制表示所有数据， 4个数据每个8位
    end
end
clear i;
clear j;

