% step 1:�õ�����ֵ���ܵ���Կ����ѡ����������ͼ��
function [s,c0]=recovers(row,column)
siz=row*column;
N=256;
% 1. ѡ��ȫ�������
choose1=zeros(row,column);
imwrite(choose1, 'choose1.bmp');
%���ܵ�������
Decry('C:\MATLAB6p5\work\Tongxiaojunattack\choose1.bmp', 'C:\MATLAB6p5\work\Tongxiaojunattack\pchoose1.bmp', 0, 3, 1);

pchoose1=imread('C:\MATLAB6p5\work\Tongxiaojunattack\pchoose1.bmp');

a = reshape(pchoose1,siz, 1);


% 2. ѡ������255
choose2=uint8(N-1);
imwrite(choose2, 'choose2.bmp');
Decry('C:\MATLAB6p5\work\Tongxiaojunattack\choose2.bmp', 'C:\MATLAB6p5\work\Tongxiaojunattack\pchoose2.bmp', 0, 3, 1);

pchoose2=imread('C:\MATLAB6p5\work\Tongxiaojunattack\pchoose2.bmp');

b=pchoose2;
% 3.������Կ��s�ĵ�һ������ s1 �� ������ֵ c0;������ȼ۵�ֵ��ȡ����һ���ɡ�
s1=N/2-1/2*mod(double(a(1))+double(b),N)-1/2; c01=mod(double(a(1))+s1,N);

s2=N-1/2*mod(double(a(1))+double(b),N)-1/2; c02=mod(double(a(1))+s2,N);

% 4.�õ� ��Կ�� s �ͷ�����ֵ c0
s=256-double(a);
s(1)=s1;
c0=c01;
