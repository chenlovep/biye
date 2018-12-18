close all
clear

imageFileName = 'brain_n.tif';
cNum = 3;
m = 2;
winSize = 3;
maxIter = 500;
thrE    = 0.001;

% FLICM
[imOut,iter] = FLICM_clustering( imageFileName, cNum, m, winSize, maxIter, thrE );
disp(sprintf('Total Iterations = %d',iter));

% Show results
figure, imshow( imOut )
