%2010-7-5�յ�ͨ����ʵ���˹����㷨���������̡�
%�����㷨���
clear;
clc;

% �����ǻҶ�ͼ��
% 0���������������Կ
% 3��C0
% 2����ʾ����
% Encry('C:\MATLAB6p5\work\China\girl.bmp', 'C:\MATLAB6p5\work\China\cy.bmp', 0, 3, 2);
%��������ܵ����ģ�����¼������Կ��s_obj��������Կ��matrix_obj����Ϊ�����Ƚ���

r=3;%��������
% [goal,key1,key2]=Encry('baboo.bmp', 'cy.bmp', 0, 3, r);
%goalΪ������ͼ�񣬼�����Ŀ�꣬key1,key2�Ǽ��ܹ����еĸ�����Կ����
%��Щ�ؼ���������ϵͳ�������أ��������Ϊ�˷���Ƚ����ǵõ�����Կ���������Կ���Ĺ�ϵ�����
[goal,key1,key2]=Encry('lena_bw.bmp', 'cy.bmp', 0, 3, r);%�������ĵõ�����������cy����˵goal

N=256;
[row, column]=size(goal);
siz=row*column;
%����broken��������ÿ�ֵĵ�Ч��Կ��
[s,c0,L]=broken(row,column,r);


%����Ŀ��ͼ��
for j=r:-1:1
    goal=reshape(goal,siz,1);
    p_middle=goal(L{j});%������
    p_middle=uint8(p_middle);
    plain=zeros(siz,1);
    
    %�ָ���һ������
    plain(1)=mod(double(bitxor(p_middle(1),uint8(c0(j))))-s{j}(1),256);

%�ָ���������ֵ
    for i = 2:siz
        plain(i) = mod(double(bitxor(p_middle(i),p_middle(i-1)))+N-s{j}(i), 256);
    end
    goal=plain;
end
plain=reshape(plain, row, column);
P=imread('lena_bw.bmp');
P=double(P);
cha=sum(sum(abs(P-plain)));%�жϵõ�������ͼ���ԭʼ���ĵĲ��
