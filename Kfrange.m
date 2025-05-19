function [ B ] = Kfrange( A,n )
%逐个减去n个顶点，图A的Kf的变化
%   特意删除攻击
N=max(size(A));
a=2*Kf(Laplacian(A))/(N*(N-1));
B=zeros(1,n);
d = zeros(1,N);
for i=1:N;
    for ii=1:N;
        d(1,i)=d(1,i)+A(i,ii);
    end
end
[d,rank]=sort(d,'descend');
for i=1:n
    k=rank(1,1:i);Aa=A;
    Aa(k,:)=[];Aa(:,k)=[];R=0;
    b=2*Kf(Laplacian(Aa))/((N-i)*(N-1-i));
    B(1,i)=(b-a)/a;
end
end

