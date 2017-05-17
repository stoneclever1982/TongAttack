%破解过程的主函数，s,c0,L为返回的各轮的密钥流
function [s,c0,L]=broken(row,column,r, key, X0)
    N=256;
% 1 构造选择密文图像；
    %  1.1 构造恢复像素值加密密钥s,c0所需的密文图像
    cho1=zeros(row,column);  % 选择全零的密文
    cho2=uint8(cho1+N-1);    % 2. 选择密文255
    cho1=uint8(cho1);
    imwrite(cho1, 'cho1.bmp');
    imwrite(cho2, 'cho2.bmp');
    % 1.2 构造恢复解密置乱向量L所需的密文图像
    siz=row*column;
    number=ceil(log2(siz)/log2(256));
    tmp1=[0:siz-1]';
    tmpx = zeros(siz,1);
    for i = 1:number
        chosen{i} = rem(tmp1,256);
        tmpx = chosen{i};
        tmp1 = (tmp1 - tmpx)./256;
        chosen{i}=uint8(chosen{i});
        chosen{i} = reshape(chosen{i}, row, column);
        filename = sprintf('chosen%d.bmp',i);
        imwrite(chosen{i}, filename);
    end
    
% 2 按轮生成s,c0,L；     
    for j=1:r
        % 2.1计算s,c0
        temp=zeros(siz,1);
        %2.1.1解密cho{1,2} j 轮
        Decry('cho1.bmp', 'pcho1.bmp', key, X0, j);
        Decry('cho2.bmp', 'pcho2.bmp', key, X0, j);
        pcho1=imread('pcho1.bmp');
        pcho2=imread('pcho2.bmp');
       % 2.1.2 判断当前是第几轮，去掉前面 (j-1) 轮的密文，留下第 j 轮的中间图像。 
        if j ~= 1
            pcho1=oneround(pcho1,s,c0,L,j-1);
            pcho2=oneround(pcho2,s,c0,L,j-1);
        end        
        % 2.1.3计算当前的密钥流
        pcho1=reshape(pcho1,siz, 1);
        pcho1=double(pcho1);
        pcho2=double(pcho2);
        s{j} =256-pcho1;
        s{j}(1)=N/2-1/2 * mod(pcho1(1) + pcho2(1), N)-1/2;%第 j 轮所用 s{j}
        c0(j)=mod(double(pcho1(1))+s{j}(1),N);%第j轮所用c0(j)             
        
        %2.2 计算 L
        % 解密chosen{i} j 轮,并将解密结果写入img{i}
        for i=1:number
            filename = sprintf('chosen%d.bmp',i);
            filename2=sprintf('pchosen%d.bmp',i);
            Decry(filename,filename2, key, X0, j);
            img{i}=imread(filename2);
            img{i} = reshape(img{i}, row*column, 1);
            % 2.1.2 判断当前是第几轮，去掉前面 (j-1) 轮的密文，留下第 j 轮的中间图像。
            if (j ~= 1)
                img{i}=oneround(img{i},s,c0,L,j-1);
            end
            
            %2.1.3 对明文图象 img{i} 进行象素值加密得到置乱前的值 zchosen{i}            
            img{i} = uint8(mod(double(img{i}) + s{j}, 256));
            zchosen{i} = zeros(siz, 1);
            zchosen{i}(1)=bitxor(img{i}(1),uint8(c0(j)));
            for t = 2:siz
                zchosen{i}(t) = bitxor(uint8(zchosen{i}(t-1)), uint8(img{i}(t)));
            end
             %2.1.4 计算解密置乱向量L 
            if i==1
                temp=temp+zchosen{i};
            else
                temp=temp+zchosen{i}*256^(i-1);
            end  
        end
        L{j}=temp+1;%第j轮解密所需置乱向量  
    end