% step 1:得到像素值加密的密钥流；选择两幅密文图像
function [s,c0]=recovers(row,column)
siz=row*column;
N=256;
% 1. 选择全零的密文
choose1=zeros(row,column);
imwrite(choose1, 'choose1.bmp');
%解密得其明文
Decry('C:\MATLAB6p5\work\Tongxiaojunattack\choose1.bmp', 'C:\MATLAB6p5\work\Tongxiaojunattack\pchoose1.bmp', 0, 3, 1);

pchoose1=imread('C:\MATLAB6p5\work\Tongxiaojunattack\pchoose1.bmp');

a = reshape(pchoose1,siz, 1);


% 2. 选择密文255
choose2=uint8(N-1);
imwrite(choose2, 'choose2.bmp');
Decry('C:\MATLAB6p5\work\Tongxiaojunattack\choose2.bmp', 'C:\MATLAB6p5\work\Tongxiaojunattack\pchoose2.bmp', 0, 3, 1);

pchoose2=imread('C:\MATLAB6p5\work\Tongxiaojunattack\pchoose2.bmp');

b=pchoose2;
% 3.计算密钥流s的第一个分量 s1 和 反馈初值 c0;有两组等价的值，取其中一组便可。
s1=N/2-1/2*mod(double(a(1))+double(b),N)-1/2; c01=mod(double(a(1))+s1,N);

s2=N-1/2*mod(double(a(1))+double(b),N)-1/2; c02=mod(double(a(1))+s2,N);

% 4.得到 密钥流 s 和反馈初值 c0
s=256-double(a);
s(1)=s1;
c0=c01;
