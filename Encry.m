function c = Encry(imgFile, orFile, key, x0, lun)
%% imgFile�������ܵ�ͼ����ļ���
%% orFile�� ����ͼ�󱣴�Ľ��
%% key����Կ
%% x0�� ������ֵ
%% lun����������


%% ��ȡͼ������
img = double(imread(imgFile));
[m,n] = size(img);

img = reshape(img, m*n, 1);

rand('seed', key(1));

%%%ʹ�������ģ��������Կ��
%key1 = ceil(256*rand(m*n, lun));%������Կ��
%%%ʹ�û���ϵͳ������Կ��
key1_tmp = produceKey(key(1), key(2), m*n*lun);
key1_tmp = reshape(key1_tmp, m*n, lun);
key1 = ceil(256*key1_tmp);%������Կ��


%%% produce the keystream for scrabling
% rand('seed', key(1)+1);
% key2 = rand(m*n, lun);          % ������Կ
[W, L, H, blkx, blky, m1, n1] = baker3_para(m, n, key(1), key(2), 0, 0);

para_scrable = {W, L, H, blkx, blky, m1, n1};



for i = 1:lun
    img = OneLun(key1(:,i), para_scrable, img, x0);
end


c = uint8(reshape(img, m, n));

imwrite(c, orFile);