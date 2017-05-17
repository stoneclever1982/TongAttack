function y = OneLun(k1, k2, img, x0)
% 加密过程的一轮
siz = size(img, 1);

img = uint8(mod(img + k1, 256));

% 结果保存在y中
y = zeros(siz, 1);
% 第一个象素
y(1) = bitxor(img(1),uint8(x0));

% 后续的象素加密
for i = 2:siz
    y(i) = bitxor(y(i-1), img(i));
end


%% 置乱
% [tmp, index] = sort(k2);
% y = y(index);

%[W, L, H, blkx, blky, m, n] = k2;
W = k2{1};
L = k2{2};
H = k2{3};
blkx = k2{4};
blky = k2{5};
m1 = k2{6};
n1 = k2{7};
y = baker3(y, W, L, H, m1, n1, 3);

