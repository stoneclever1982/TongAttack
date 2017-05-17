function y  = attack_fun(filename)
%攻击算法入口
    % 必须是灰度图象
    % x0,y0：the key of chaos system
    % 3：C0
    % 2：表示两轮
    % Encry('C:\MATLAB6p5\work\China\girl.bmp', 'C:\MATLAB6p5\work\China\cy.bmp', 0, 3, 2);
    %读入待解密的密文，并记录加密密钥流s_obj和置乱密钥流matrix_obj以作为后来比较用
    x0 = 0.48598270305999636;
    y0 = 0.6259912148180255;

    r=3;%加密轮数
    % [goal,key1,key2]=Encry('baboo.bmp', 'cy.bmp', 0, 3, r);
    %goal为待解密图像，即攻击目标，key1,key2是加密过程中的各轮密钥流，
    %这些关键参数加密系统本不返回，这里仅仅为了方便比较我们得到的密钥流与加密密钥流的关系而输出
    X0 = 3;
    goal=Encry(filename, 'cy.bmp', [x0,y0], X0, r);%加密明文得到待解密密文cy或者说goal

    N=256;
    [row, column]=size(goal);
    siz=row*column;
    %利用broken函数计算每轮的等效密钥流
    [s,c0,L]=broken(row,column,r,[x0,y0], X0);


    %解密目标图像
    for j=r:-1:1
        goal=reshape(goal,siz,1);
        p_middle=goal(L{j});%逆置乱
        p_middle=uint8(p_middle);
        plain=zeros(siz,1);

        %恢复第一个像素
        plain(1)=mod(double(bitxor(p_middle(1),uint8(c0(j))))-s{j}(1),256);

    %恢复其他像素值
        for i = 2:siz
            plain(i) = mod(double(bitxor(p_middle(i),p_middle(i-1)))+N-s{j}(i), 256);
        end
        goal=plain;
    end
    plain=reshape(plain, row, column);
    P=imread(filename);
    P=double(P);
    cha=sum(sum(abs(P-plain)));%判断得到的明文图像和原始明文的差距
    
    
    subplot(1,2,1), subimage(uint8(plain)), title(sprintf('result of crack(the differece is %d)', cha));
    subplot(1,2,2), subimage(uint8(P)), title('origine imgage');
end