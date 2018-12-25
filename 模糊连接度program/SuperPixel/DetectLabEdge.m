function labedge = DetectLabEdge(labimg)

L = labimg(:,:,1);
A = labimg(:,:,2);
B = labimg(:,:,3);
[M, N] = size(L);
s = M*N;

temp = L;
temp(1, :) = [];
L_rise = [temp; L(M, :)];
temp = L;
temp(M, :) = [];
L_fall = [L(1, :); temp];
temp = L;
temp(:, N) = [];
L_right = [L(:, 1) temp];
temp = L;
temp(:, 1) = [];
L_left = [temp L(:, N)];
L_edge = abs(L_fall-L_rise)+abs(L_right-L_left);


temp = A;
temp(1, :) = [];
A_rise = [temp; A(M, :)];
temp = A;
temp(M, :) = [];
A_fall = [A(1, :); temp];
temp = A;
temp(:, N) = [];
A_right = [A(:, 1) temp];
temp = A;
temp(:, 1) = [];
A_left = [temp A(:, N)];
A_edge = abs(A_fall-A_rise)+abs(A_right-A_left);

temp = B;
temp(1, :) = [];
B_rise = [temp; B(M, :)];
temp = B;
temp(M, :) = [];
B_fall = [B(1, :); temp];
temp = B;
temp(:, N) = [];
B_right = [B(:, 1) temp];
temp = B;
temp(:, 1) = [];
B_left = [temp B(:, N)];
B_edge = abs(B_fall-B_rise)+abs(B_right-B_left);

labedge = L_edge + A_edge + B_edge;

end