function [ adj ] = ERR( N,p );
%生成必定连通的修正随机ER图
%   概率p要求大于2/n
adj=zeros(N,N);
if p>(2/N)
    p=(N*p-2)/(N-2);
else
    p=0;
end
if randi(1)==1  %生成路
    for i=1:N-1
        adj(i,i+1)=1;
        adj(i+1,i)=1;
    end
    for m=1:N-2
        for n=m+2:N
            if(rand(1,1)<p)  %以p的概率生成边
                adj(m,n)=1;  %这里两句给邻接表赋值
                adj(n,m)=1;
            end
        end
    end
else         %生成星图
    adj(1,:)=1;
    adj(:,1)=1;
    adj(1,1)=0;
    for m=2:N-1
        for n=m+1:N
            if(rand(1,1)<p)  %以p的概率生成边
                adj(m,n)=1;  %这里两句给邻接表赋值
                adj(n,m)=1;
            end
        end
    end
end
end

