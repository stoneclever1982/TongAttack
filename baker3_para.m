function [W, L, H, blkx, blky, m, n] = baker3_para(M, N, key1, key2, bx, by)


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
    
    
    %blkx and blky are the size of the mini block on the x axis and y axis
    if(bx == 0  || by == 0)
        blkx = floor(W/8);
        blky = floor(L/8);
    else
        blkx = bx;
        blky = by;
    end
    
    %%%for the example of the paper, I have to set the blkx and blky
    %%%manually
    if(M ==8 && N == 8)
        W = 4; L = 4; H = 4;
        blkx = 2;
        blky = 2;
    end
    
    
    key_tmp = produceKey(key1, key2, (blkx+blky));
    

	m_tmp = ceil(key_tmp(1 : blkx - 1)*W);                   m_tmp(blkx) = W;
    n_tmp = ceil(key_tmp(blkx : blkx + blky - 2)*L);         n_tmp(blky) = L;
    n_tmp = sort(n_tmp);
    m_tmp = sort(m_tmp);
        

	n = n_tmp - [0, n_tmp(1:blky - 1)];
	m = m_tmp - [0, m_tmp(1:blkx - 1)];

        
    % check is there a element of n_tmp which is equal to the succesive element
	for j = 2:blky
        if(n(j) == 0)
            if(j<blky && n(j+1)>=2)
                n(j) = 1;
                n(j+1) = n(j+1)-1;
            else
                fprintf('the key of scrabling is not correct\n');
                return;
            end
        end
    end
        
	for j = 1:blkx
        if(m(j) == 0)
            if(j<blkx && m(j+1)>=2)
                m(j) = 1;
                m(j+1) = m(j+1)-1;
            else
                fprintf('the key of scrabling is not correct\n');
                return;
            end
        end
	end

    
end