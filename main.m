clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=======================================================
%               attack on the Tongxiaojun Algorithm
% is an example for the paper
%=======================================================
if true
    im = 1:64;
    im = reshape(im, 8, 8);
    imwrite(uint8(im), 'example.bmp');
    
    attack_fun('example.bmp');
end












%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=======================================================
%               attack on the Tongxiaojun Algorithm
% is equal to the attack.m
%=======================================================
if flase
    attack_fun('lena_bw.bmp');
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=======================================================
%               test for the baker3
%=======================================================
if flase
    %parameters
    M = 4;
    N = 4;
    H = 4;
    n = [3, 1];
    m = [1, 3];

    im = reshape(1:64, 8,8);

    im2 = baker3(im, M, N, H, m, n, 3);
    im3 = baker3_ni(im2, M,N,H,m,n, 3);
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%=======================================================
%               test fot Encryption and Decryption
%=======================================================
if flase
    % 必须是灰度图象
    % 0：生成随机数的密钥
    % 3：C0
    % 2：表示两轮
    % Encry('C:\MATLAB6p5\work\China\girl.bmp', 'C:\MATLAB6p5\work\China\cy.bmp', 0, 3, 2);
    x0 = 0.48598270305999636;
    y0 = 0.6259912148180255;
    Encry('girl.bmp', 'cy.bmp', [x0,y0], 3, 1);

    % 0：生成随机数的密钥
    % 3：C0
    % 2：表示两轮
    % Decry('C:\MATLAB6p5\work\China\cy.bmp', 'C:\MATLAB6p5\work\China\cy_I.bmp', 0, 3, 2);
    Decry('cy.bmp', 'cy_I.bmp', [x0, y0], 3, 1);
end