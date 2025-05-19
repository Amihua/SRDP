function [ adj ] = ERR( N,p );
%���ɱض���ͨ���������ERͼ
%   ����pҪ�����2/n
adj=zeros(N,N);
if p>(2/N)
    p=(N*p-2)/(N-2);
else
    p=0;
end
if randi(1)==1  %����·
    for i=1:N-1
        adj(i,i+1)=1;
        adj(i+1,i)=1;
    end
    for m=1:N-2
        for n=m+2:N
            if(rand(1,1)<p)  %��p�ĸ������ɱ�
                adj(m,n)=1;  %����������ڽӱ�ֵ
                adj(n,m)=1;
            end
        end
    end
else         %������ͼ
    adj(1,:)=1;
    adj(:,1)=1;
    adj(1,1)=0;
    for m=2:N-1
        for n=m+1:N
            if(rand(1,1)<p)  %��p�ĸ������ɱ�
                adj(m,n)=1;  %����������ڽӱ�ֵ
                adj(n,m)=1;
            end
        end
    end
end
end

