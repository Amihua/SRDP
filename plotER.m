function c= plotER( A )
N=max(size(A));
position=zeros(N,2);   %点位置信息position,一共有N组数据，每组数据有2个信息
for m=1:N           %给每个点安排位置，围成一个圆
    position(m,1)=cos(m/N*2*pi);
    position(m,2)=sin(m/N*2*pi);
end
figure('name','ER随机图');
hold on;
plot(position(:,1),position(:,2),'d')
for m = 1:N
    for n = m+1:N
        if(A(m,n)==1)  %如果有边就画出来
            plot(position([m,n],1),position([m,n],2));
        end
    end
end
hold off;

end

