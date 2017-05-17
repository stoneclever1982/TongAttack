function key = produceKey(x0, y0, N)
%%%生成长度为N的混沌系统状态
% key is in (0,1);


%%%%
%%x0 = 0.48598270305999636;
%%y0 = 0.6259912148180255;
%%key = produceKey(x0, y0, 1000);
%%
%%

%%参数
dert = 0.99;
fv = 0.0005;


X = zeros(1,N);
Y = zeros(1,N);
X(1) = x0;
Y(1) = y0;

key = zeros(1,N);

for i = 2:N+1
    X(i) = 2*X(i-1)^2 - 1;
    if( (X(i-1) >= dert && X(i-1)<=1) || (X(i-1) >= -0.5-fv && X(i-1) <= -0.5+fv) )
        X(i) = X(i) - fv;
    else
        ;%X(i) = X(i);
    end
    
    Y(i) = 4*Y(i-1)^3 - 3*Y(i-1);
    if( (Y(i-1) >= dert && Y(i-1) <=1) || (Y(i-1) >= -fv && Y(i-1) <= fv) )
        Y(i) = Y(i) - fv;
    else
        ;%Y(i) = Y(i);
    end
    
    if(X(i-1) + Y(i-1) < 0)
        key(i-1) = X(i);
    else
        key(i-1) = Y(i);
    end
end


% 把key的范围转换到0-1,便于后续处理
key = (key+1)/2;

