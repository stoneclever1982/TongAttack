function p=oneround(goal,s,c0,L,r)
%�������Ĺ��ܣ����r�ֹ������ܹ��̡�L��Ӧ��temp+1;goal��Ҫ�����ּ��ܵ�ͼ��(ѡ������ͼ��)��
%��ûд��
[row,column]=size(goal);
siz=row*column;
N=256;
goal=reshape(goal,siz,1);
goal=double(goal);


%������r�ּ���
for i=1:r
    s=s{r};
    c=c0(r);
    L0=L{r};
    s=double(s);
    
    % 1.����ֵ����
    img = uint8(mod(goal + s, 256));
    p = zeros(siz, 1);
    %  1.1 ��һ������
    p(1) = bitxor(img(1),uint8(c));
    %  1.2 ���������ؼ���
    for i = 2:siz
        p(i) = bitxor(p(i-1), img(i));
    end
    
    % 2. ͼ������
    if (siz~=1)
        [tmp, index] = sort(L0);
        p = p(index);
    end
    goal=p;
end