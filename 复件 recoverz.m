function temp=recoverz(row,column,s,c0)

siz=row*column;
number=log2(siz)/log2(256);
tmp1=[0:siz-1]';
chosen1=rem(tmp1,256);%256���ƺ��λ�ϵ�����Ӧ��ͼ��
chosen2=(tmp1-chosen1)./256,256;%���Ƶ�ʮλ�ϵ�����Ӧ��ͼ��
chosen1=uint8(chosen1);
chosen2=uint8(chosen2);
imwrite(chosen1, 'chosen1.bmp');
imwrite(chosen2, 'chosen2.bmp');
%���ܵ�������
Decry('chosen1.bmp', 'C:\MATLAB6p5\work\Tongxiaojunattack\pchosen1.bmp', 0, 3, 1);
Decry('chosen2.bmp', 'C:\MATLAB6p5\work\Tongxiaojunattack\pchosen2.bmp', 0, 3, 1);

% %% ����step1���������Կ���õ�pchosen1��pchosen2����ֵ���ܺ��ͼ��
img1=imread('pchosen1.bmp');
img2=imread('pchosen2.bmp');
img1=double(img1);
img2=double(img2);
s=double(s);
% img=img1+s
%zchoose(i)=(img(i))mod N xor zchoose3(i-1);
% 
img3 = uint8(mod(img1+s, 256));
img4=uint8(mod(img2 +s, 256));
% % ��������� zchoose3,zchoose4��
zchosen1 = zeros(siz, 1);
zchosen2 = zeros(siz, 1);
% % ��һ������
zchosen1 (1) = bitxor(img3(1),uint8(c0));
zchosen2 (1) = bitxor(img4(1),uint8(c0));
% 
% % ���������ؼ���
for i = 2:siz
    zchosen1(i) = bitxor(zchosen1(i-1), img3(i));
    zchosen2(i) = bitxor(zchosen2(i-1), img4(i));
end
temp=double(zchosen2).*256+double(zchosen1);