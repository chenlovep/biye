t1=clock;
%常改的参数
imgFileName = 'E:\biye\DTIpicture\data\DTIpicture\26.jpg';%输入图像
cNum = 3;%聚类中心数量
%不常改的参数
m = 2;%指数m
winSize = 3;%局部窗口直径
maxIter = 300;%最大迭代次数
thrE = 0.00001;%收敛阈值

% FLICM
[imOut,iter] = FLICM_clustering( imgFileName, cNum, m, winSize, maxIter, thrE );
disp(sprintf('Total Iterations = %d',iter));

% Show results
figure, imshow( imOut )
disp(['etime程序总运行时间：',num2str(etime(clock,t1))]);
