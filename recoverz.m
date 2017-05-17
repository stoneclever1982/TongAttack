function temp=recoverz(row,column,s,c0)

siz=row*column;
number=ceil(log2(siz)/log2(256));
tmp1=[0:siz-1]';
tmpx = zeros(siz,1);
s=double(s);
temp=zeros(siz,1);
for i = 1:number
%     chosen{i} = rem(tmp1,256);
    chosen{i} = rem(tmp1,256);
    tmpx = chosen{i};
    tmp1 = (tmp1 - tmpx)./256;
    chosen{i}=uint8(chosen{i});
    filename = sprintf('chosen%d.bmp',i);
    imwrite(chosen{i}, filename);
    filename2=sprintf('pchosen%d.bmp',i);
    Decry(filename, filename2, 0, 3, 1);
    img{i}=imread(filename2);
    
    %对明文图象进行象素值加密得到置乱前的值
    
    img{i} = uint8(mod(double(img{i})+s, 256));
    zchosen{i} = zeros(siz, 1);
    zchosen{i}(1)=bitxor(img{i}(1),uint8(c0));
    for j = 2:siz
        zchosen{i}(j) = bitxor(uint8(zchosen{i}(j-1)), uint8(img{i}(j)));
    end
    aa=1;
    if i==1
        temp=temp+zchosen{i};
    else
        temp=temp+zchosen{i}*256^(i-1);
    end
end

