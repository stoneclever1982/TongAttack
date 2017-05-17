function imp = baker3(im, M, N, H, m, n, times)
    % times is the number of use baker3p
    
    [a,b] = size(im);
    
    for i = 1:times
        im = baker3p(im, M, N, H, m, n);
    end

    imp = reshape(im, a,b);
    
end
