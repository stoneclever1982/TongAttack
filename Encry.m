function c = Encry(imgFile, orFile, key, x0, lun)
%% imgFile，待加密的图象的文件名
%% orFile， 加密图象保存的结果
%% key，密钥
%% x0， 反馈初值
%% lun，加密轮数


%% 读取图象数据
img = double(imread(imgFile));
[m,n] = size(img);

img = reshape(img, m*n, 1);

rand('seed', key(1));

%%%使用随机数模拟生成秘钥流
%key1 = ceil(256*rand(m*n, lun));%加密密钥流
%%%使用混沌系统生成密钥流
key1_tmp = produceKey(key(1), key(2), m*n*lun);
key1_tmp = reshape(key1_tmp, m*n, lun);
key1 = ceil(256*key1_tmp);%加密密钥流


%%% produce the keystream for scrabling
% rand('seed', key(1)+1);
% key2 = rand(m*n, lun);          % 置乱密钥
[W, L, H, blkx, blky, m1, n1] = baker3_para(m, n, key(1), key(2), 0, 0);

para_scrable = {W, L, H, blkx, blky, m1, n1};



for i = 1:lun
    img = OneLun(key1(:,i), para_scrable, img, x0);
end


c = uint8(reshape(img, m, n));

imwrite(c, orFile);