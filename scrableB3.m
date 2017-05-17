function Q = scrableB3(P)
%%%%
%使用三维baker映射对图像进行置乱

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%parameters
%blkx is the # of small blocks on the length.
%blky is the # of small blocks on the width.
blkx = 4;
blky = 4;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M,N] = size(P);

if(mod(M,4) ~= 0)
    fprintf('the size of the image must be divisible by 4\n');
end

% caculate the length(W), width(L), and height(H) of the image witch is transfered
% form 2D to 3D
if(mod(N,8) == 0)
    W = M/4;    L = N/8;    H = 32;
elseif ( mod(N,4) == 0 )
    W = M/4;    L = N/4;    H =16;
elseif ( mod(N,2) == 0 )
    W = M/4;    L = N;      H = 4;
end


%% produce the lengths(n(i)), width(m(i)) of the small block on the length.
rand('seed', 11);
flag = 0;       % if flag == 1 means: n and m are produced sucessfully.
for i = 1:10
    n_tmp = ceil(rand(1, blkx - 1)*W);     n_tmp(blkx) = W;
    m_tmp = ceil(rand(1, blky - 1)*L);     m_tmp(blky) = L;
    n_tmp = sort(n_tmp);
    m_tmp = sort(m_tmp);
    n = n_tmp - [0, n_tmp(1:blkx - 1)];
    m = m_tmp - [0, m_tmp(1:blky - 1)];
    
    if(sum(n==0) > 1 || sum(m==0) > 1)
        flag = 1;
        break;
    end
end
if(flag == 0)
    fprintf('n and m are produced failed.\n');
end


F = zeros(1, blkx);
for i = 2:blkx
    F(i) = sum(n(1:i-1));
end
G = zeros(1, blky);
for i = 2:blky
    G(i) = sum(m(1:i-1));
end

for x = 1:W
    for y = 1:L
        for z = 1:H
            %change (x,y,z) to (xp, yp, zp) which is the new position to
            %the pixel (x,y,z)
            i = 1;
            j = 1;
            num = (W*G(j) + m(j)*F(i))*H + z*m(j)*n(i) + (y-G(j))*n(i) + x -F(i);
            xp = mod  (mod(num, W*L),W);
            yp = floor(mod(num, W*L)/W);
            zp = floor(mod(num/WL));
            
        end
    end
end






