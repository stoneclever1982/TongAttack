function imp = baker3p_ni(im, M,N,H, n, m)
    %scrable the pic(im) with baker 3D
    %im: the size must be (len,1)
    %imp: the size is (len, 1)
    
    
    num_n = size(n,2); %the size of n
    num_m = size(m,2); %the size of m
    
    F = zeros(num_n, 1);
    G = zeros(num_m, 1);
    
    for i = 2:num_n+1
        F(i) = F(i-1) + n(i-1);
    end
    for i = 2:num_m+1
        G(i) = G(i-1) + m(i-1);
    end
    
    
    imp = zeros(M, N, H);
    
    cur = 0;
    for i = 1:num_n
        for j = 1:num_m
            len = n(i)*m(j)*H;
            this = im(cur+1:cur+len);
            imp(F(i)+1:F(i+1),G(j)+1:G(j+1),:) = reshape(this, n(i), m(j),H);
            siz = size(this);
            %imp, = reshape(this,len,1);
            cur = cur+len;
        end
    end
    
    imp = reshape(imp,M*N*H,1);
end
