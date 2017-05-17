function p=oneround(goal,s,c0,L,r)
%本函数的功能，完成r轮攻击解密过程。L对应着temp+1;goal需要进行轮加密的图像(选择密文图像)，
%还没写好
[row,column]=size(goal);
siz=row*column;
N=256;
goal=reshape(goal,siz,1);
goal=double(goal);


%共进行r轮加密
for i=1:r
    s=s{r};
    c=c0(r);
    L0=L{r};
    s=double(s);
    
    % 1.像素值加密
    img = uint8(mod(goal + s, 256));
    p = zeros(siz, 1);
    %  1.1 第一个象素
    p(1) = bitxor(img(1),uint8(c));
    %  1.2 后续的象素加密
    for i = 2:siz
        p(i) = bitxor(p(i-1), img(i));
    end
    
    % 2. 图像置乱
    if (siz~=1)
        [tmp, index] = sort(L0);
        p = p(index);
    end
    goal=p;
end