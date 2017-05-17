%�ƽ���̵���������s,c0,LΪ���صĸ��ֵ���Կ��
function [s,c0,L]=broken(row,column,r, key, X0)
    N=256;
% 1 ����ѡ������ͼ��
    %  1.1 ����ָ�����ֵ������Կs,c0���������ͼ��
    cho1=zeros(row,column);  % ѡ��ȫ�������
    cho2=uint8(cho1+N-1);    % 2. ѡ������255
    cho1=uint8(cho1);
    imwrite(cho1, 'cho1.bmp');
    imwrite(cho2, 'cho2.bmp');
    % 1.2 ����ָ�������������L���������ͼ��
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
    
% 2 ��������s,c0,L��     
    for j=1:r
        % 2.1����s,c0
        temp=zeros(siz,1);
        %2.1.1����cho{1,2} j ��
        Decry('cho1.bmp', 'pcho1.bmp', key, X0, j);
        Decry('cho2.bmp', 'pcho2.bmp', key, X0, j);
        pcho1=imread('pcho1.bmp');
        pcho2=imread('pcho2.bmp');
       % 2.1.2 �жϵ�ǰ�ǵڼ��֣�ȥ��ǰ�� (j-1) �ֵ����ģ����µ� j �ֵ��м�ͼ�� 
        if j ~= 1
            pcho1=oneround(pcho1,s,c0,L,j-1);
            pcho2=oneround(pcho2,s,c0,L,j-1);
        end        
        % 2.1.3���㵱ǰ����Կ��
        pcho1=reshape(pcho1,siz, 1);
        pcho1=double(pcho1);
        pcho2=double(pcho2);
        s{j} =256-pcho1;
        s{j}(1)=N/2-1/2 * mod(pcho1(1) + pcho2(1), N)-1/2;%�� j ������ s{j}
        c0(j)=mod(double(pcho1(1))+s{j}(1),N);%��j������c0(j)             
        
        %2.2 ���� L
        % ����chosen{i} j ��,�������ܽ��д��img{i}
        for i=1:number
            filename = sprintf('chosen%d.bmp',i);
            filename2=sprintf('pchosen%d.bmp',i);
            Decry(filename,filename2, key, X0, j);
            img{i}=imread(filename2);
            img{i} = reshape(img{i}, row*column, 1);
            % 2.1.2 �жϵ�ǰ�ǵڼ��֣�ȥ��ǰ�� (j-1) �ֵ����ģ����µ� j �ֵ��м�ͼ��
            if (j ~= 1)
                img{i}=oneround(img{i},s,c0,L,j-1);
            end
            
            %2.1.3 ������ͼ�� img{i} ��������ֵ���ܵõ�����ǰ��ֵ zchosen{i}            
            img{i} = uint8(mod(double(img{i}) + s{j}, 256));
            zchosen{i} = zeros(siz, 1);
            zchosen{i}(1)=bitxor(img{i}(1),uint8(c0(j)));
            for t = 2:siz
                zchosen{i}(t) = bitxor(uint8(zchosen{i}(t-1)), uint8(img{i}(t)));
            end
             %2.1.4 ���������������L 
            if i==1
                temp=temp+zchosen{i};
            else
                temp=temp+zchosen{i}*256^(i-1);
            end  
        end
        L{j}=temp+1;%��j�ֽ���������������  
    end