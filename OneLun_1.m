function y = OneLun_1(k1, k2, img, x0)
%% ���ܹ��̵�һ��
siz = size(img, 1);


%% ������
% [tmp, index] = sort(k2);
% [tmp, index2] = sort(index);
% img = img(index2);
%{W, L, H, blkx, blky, m, n} = k2;
W = k2{1};
L = k2{2};
H = k2{3};
blkx = k2{4};
blky = k2{5};
m1 = k2{6};
n1 = k2{7};
img = baker3_ni(img, W, L, H, m1, n1, 3);

img = uint8(img);

% ���������y��
y = zeros(siz, 1);
% ��һ������
y(1) = mod(double(bitxor(img(1),uint8(x0)))-k1(1), 256);

% ���������ؽ���
for i = 2:siz
    y(i) = mod(double(bitxor(img(i),img(i-1)))-k1(i), 256);
end

