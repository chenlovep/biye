x = 1:2:9;

%{
%分割系数
y = 0:0.1:0.7;
FCM = [0.2545, 0.2587, 0.2679, 0.2844, 0.3394];
FCM_MRF = [0.1671, 0.18540, 0.2060, 0.2271, 0.2543];
HMRF_FCM = [0.1663, 0.18184, 0.1968, 0.2128, 0.2406];
KFCM = [0.1713, 0.1859, 0.1988, 0.2145, 0.2387];
F = [0.1346, 0.1398, 0.1432, 0.1445, 0.1589];

plot(x, FCM, '-ob', x, FCM_MRF, '-or', x, HMRF_FCM, '-ok', x, KFCM, '-og', x, F, '-om', 'LineWidth', 2);

axis = ([0, 12, 0, 0.7]);
xlim([0,10]);
ylim([0, 0.55]);
set(gca, 'XTick', [1:2:9]);
set(gca, 'YTick', [0:0.1:0.7]);

a = legend('FCM', 'FCM-MRF', 'HMRF-FCM', 'KFCM', '本文');

xlabel('噪声级别', 'FontSize', 18);
ylabel('分割系数', 'FontSize', 18);
saveas( gcf,'分割系数.jpg')


%分割熵
y = 0.8:0.05:1;
FCM = [0.8827, 0.8806, 0.8658, 0.8621, 0.8566];
KFCM = [0.9199, 0.9029, 0.8949, 0.8889, 0.8777];
HMRF_FCM = [0.9207, 0.9147, 0.9099, 0.8986, 0.8848];
FCM_MRF = [0.9231, 0.9207, 0.9197, 0.9133, 0.9085];
F = [0.9274, 0.9255, 0.9245, 0.9238, 0.9235];

plot(x, FCM, '-ob', x, FCM_MRF, '-or', x, HMRF_FCM, '-ok', x, KFCM, '-og', x, F, '-om', 'LineWidth', 2)

axis = ([0, 12, 0.7, 1]);
xlim([0, 12]);
ylim([0.8, 1]);
set(gca, 'XTick', [1:2:12]);
set(gca, 'YTick', [0.8:0.05:1]);

a = legend('FCM', 'FCM-MRF', 'HMRF-FCM', 'KFCM', '本文');
set(a, 'Fontname', 'FontWeight', 'bold')
xlabel('噪声级别', 'FontSize', 18);
ylabel('分割熵', 'FontSize', 18);
saveas( gcf,'分割熵.jpg')
%}

%正确率
y = 0.85:0.035:1;
FCM = [0.9524, 0.9406, 0.9376, 0.9121, 0.8894];
KFCM = [0.9574, 0.9542, 0.9449, 0.9341, 0.9165];
HMRF_FCM = [0.9635, 0.9525, 0.9459, 0.9323, 0.9292];
FCM_MRF = [0.9641, 0.9435, 0.9374, 0.9296, 0.9252];
F = [0.9705, 0.9649, 0.9494, 0.9434, 0.9376];

plot(x, FCM, '-ob', x, FCM_MRF, '-or', x, HMRF_FCM, '-ok', x, KFCM, '-og', x, F, '-om', 'LineWidth', 5)

axis = ([0, 12, 0.85, 1]);
xlim([0, 12]);
ylim([0.85, 1]);
set(gca, 'XTick', [1:2:12]);
set(gca, 'YTick', [0.85:0.03:1]);

a = legend('FCM', 'FCM-MRF', 'HMRF-FCM', 'KFCM', '本文');
xlabel('噪声级别', 'FontSize', 18);
ylabel('SA正确率', 'FontSize', 18);
saveas( gcf,'SA正确率.jpg')
