function imp = baker3p(im, M, N, H, n, m)
    %scrable the pic(im) with baker 3D
    %im: the size is (len,1) or (m,n) or (M,N,H)
    %imp: the size is (len,)
    
    
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
            
    
    
    im3d = reshape(im, M,N,H);
    
    imp = zeros(M*N*H, 1);
    
    cur = 0;
    for i = 1:num_n
        for j = 1:num_m
            len = n(i)*m(j)*H;
            this = im3d(F(i)+1:F(i+1),G(j)+1:G(j+1),:);
            siz = size(this);
            imp(cur+1:cur+len) = reshape(this,len,1);
            cur = cur+len;
        end
    end
    
    
end
