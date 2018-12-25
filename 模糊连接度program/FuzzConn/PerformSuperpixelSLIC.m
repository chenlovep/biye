function [klabels, kseedsx, kseedsy] = PerformSuperpixelSLIC(img_Lab, kseedsl, kseedsa, kseedsb, kseedsx, kseedsy, STEP, compactness)
%param:
%input:
%-----img_Lab原图像种子点的lab图像空间
%-----kseedsl原图像种子点lab空间中的l分量
%-----kseedsa原图像种子点lab空间中的a空间
%-----kseedsb原图像种子点lab空间中的b空间
%-----kseedsx原图像种子点的x坐标
%-----kseedsy原图像种子点的y坐标
%-----STEP每个超像素的边长
%-----compactness   超像素紧凑系数？？？？？？？？？
%output:
%-----klabels每个像素的分类标签


%原图像Lab尺度空间
[m_height, m_width, m_channel] = size(img_Lab);
%kseedsl(n,1)  -------> n为超像素个数
numseeds = size(kseedsl);
disp(fprintf('the size of kseedsl:%d-%d',numseeds(1),numseeds(2)));
img_Lab = double(img_Lab);
%像素标签格式为(x, y) (行, 列)
klabels = zeros(m_height, m_width);
%聚类尺寸
%{
clustersize = zeros(numseeds);
inv = zeros(numseeds, 1);
sigmal = zeros(numseeds, 1);
sigmaa = zeros(numseeds, 1);
sigmab = zeros(numseeds, 1);
sigmax = zeros(numseeds, 1);
sigmay = zeros(numseeds, 1);
%}
%invwt
invwt = 1/((double(STEP)/double(compactness))*(double(STEP)/double(compactness)));
%invwt = double(compactness)/double(STEP);
%distvec距离矩阵
distvec = 100000*ones(m_height, m_width);
%numseeds
numk = numseeds;

for itr = 1: 10   %迭代次数
    sigmal = zeros(numseeds);
    sigmaa = zeros(numseeds);
    sigmab = zeros(numseeds);
    sigmax = zeros(numseeds);
    sigmay = zeros(numseeds);
    clustersize = zeros(numseeds);
    inv = zeros(numseeds);
    distvec = double(100000*ones(m_height, m_width));
    
    %根据当前种子点信息计算每一个像素的归属
    for n = 1: numk(1)
        %种子点邻域范围为(2S*2S)
        y1 = max(1, kseedsy(n, 1)-STEP);
        y2 = min(m_height, kseedsy(n, 1)+STEP);
        x1 = max(1, kseedsx(n, 1)-STEP);
        x2 = min(m_width, kseedsx(n, 1)+STEP);
        %按像素计算距离
        for y = y1: y2
            for x = x1: x2
                %dist_lab = abs(img_Lab(y, x, 1)-kseedsl(n))+abs(img_Lab(y, x, 2)-kseedsa(n))+abs(img_Lab(y, x, 3)-kseedsb(n));
                %将距离归为lab空间内的三维距离和空间范围xy的距离和
                dist_lab = (img_Lab(y, x, 1)-kseedsl(n, 1))^2+(img_Lab(y, x, 2)-kseedsa(n, 1))^2+(img_Lab(y, x, 3)-kseedsb(n, 1))^2;
                dist_xy = (double(y)-kseedsy(n, 1))*(double(y)-kseedsy(n, 1)) + (double(x)-kseedsx(n, 1))*(double(x)-kseedsx(n, 1));
                %dist_xy = abs(y-kseedsy(n)) + abs(x-kseedsx(n));
                %距离 = lab色彩空间距离 + 空间距离权重×空间距离
                dist = dist_lab + dist_xy*invwt;
                %在周围最多四个种子点中找到最相似的 标记后存入klabels
                %m = (y-1)*m_width+x;
                if (dist<distvec(y, x))
                    distvec(y, x) = dist;
                    klabels(y, x) = n;
                end
            end
        end
    end
    %%%%%%%%%%**********重新计算种子点位置 使其向梯度最小地方移动
    %重新计算种子点位置，依据类别中数据的均值
    ind = 1;
    for r = 1: m_height
        for c = 1: m_width
            %每个元素的每个维度的变化值
            sigmal(klabels(r, c),1) = sigmal(klabels(r, c),1)+img_Lab(r, c, 1);
            sigmaa(klabels(r, c),1) = sigmaa(klabels(r, c),1)+img_Lab(r, c, 2);
            sigmab(klabels(r, c),1) = sigmab(klabels(r, c),1)+img_Lab(r, c, 3);
            sigmax(klabels(r, c),1) = sigmax(klabels(r, c),1)+c;
            sigmay(klabels(r, c),1) = sigmay(klabels(r, c),1)+r;
            %clustersize统计每个标签出现的次数
            clustersize(klabels(r, c),1) = clustersize(klabels(r, c),1)+1;
        end
    end
    for m = 1: numseeds
        if (clustersize(m, 1)<=0)
            clustersize(m, 1) = 1; 
        end
        inv(m, 1) = 1/clustersize(m, 1);
    end
    for m = 1: numseeds
        kseedsl(m, 1) = sigmal(m, 1)*inv(m, 1);
        kseedsa(m, 1) = sigmaa(m, 1)*inv(m, 1);
        kseedsb(m, 1) = sigmab(m, 1)*inv(m, 1);
        kseedsx(m, 1) = sigmax(m, 1)*inv(m, 1);
        kseedsy(m, 1) = sigmay(m, 1)*inv(m, 1);
    end
end
end