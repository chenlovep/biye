function nlabels = EnforceLabelConnectivity(img_Lab, labels, K)
%params:
%input:
%-----img_Lab:原图像的lab空间
%-----labels:当前的标签图像
%-----K:类别数
%output:
%-----nlabels:合并后的标签图像
dx = [-1, 0, 1, 0];
dy = [0, -1, 0, 1];
[m_height, m_width, m_channel] = size(img_Lab);
[M, N] = size(labels);
SUPSZ = (m_height*m_width)/K;   %标准每个超像素区域面积
nlabels = (-1)*ones(M, N);      

label = 1;
adjlabel = 1;
xvec = zeros(m_height*m_width, 1);
yvec = zeros(m_height*m_width, 1);
m = 1;
n = 1;

for j = 1: m_height
    for k = 1: m_width
        %逐点寻找未标记的区域
        if (0>nlabels(m, n))
            %找到一个新区域后用label标记该区域的起点
            nlabels(m, n) = label;
            %开始一个新的分割 记录起点坐标
            xvec(1, 1) = k;
            yvec(1, 1) = j;
            %如果起点与某个已知区域相连 用adjlabel记录该区域编号 如果当前区域过小则与相邻区域合并
            for i = 1: 4
                x = xvec(1, 1)+dx(1, i);
                y = yvec(1, 1)+dy(1, i);
                if (x>0 && x<=m_width && y>0 && y<=m_height)
                    if (nlabels(y, x)>0)
                        adjlabel = nlabels(y, x);
                    end
                end
            end
            %逐点搜索当前区域的所有点 将当前区域的坐标存到xvec和yvec中 统计区域面积
            count = 2;
            c = 1;
            %停止扩散
            while (c<=count)
                for i = 1: 4
                    x = xvec(c, 1)+dx(1, i);
                    y = yvec(c, 1)+dy(1, i);
                    if (x>0 && x<=m_width && y>0 && y<=m_height)
                        %表明(m,n)与(y,x)隶属于同一类别
                        if (0>nlabels(y, x) && labels(m, n)==labels(y, x))
                            xvec(count, 1) = x;
                            yvec(count, 1) = y;
                            nlabels(y, x) = label;
                            count = count+1;
                        end
                    end
                end
                c = c+1;
            end
            %过小的区域与相邻的区域合并
            %该类别区域过小则要
            if (count<(SUPSZ/4))
                for c = 1: (count-1)
                    nlabels(yvec(c, 1), xvec(c, 1)) = adjlabel;
                end
                %label编号要取消 改为上一个编号重新计数
                label = label-1;
            end
            %标签计数器自加
            label = label+1;
            %%%%%%%%%%%%%%
        end
        %主计数器自加
        n = n+1;
        if (n>m_width)
            n = 1;
            m = m+1;
        end
        %%%%%%%%%%%%
    end
end

end


