function [ B ] = Kfrange2( A,n )
%逐个减去n个顶点，图A的Kf的变化
%   随机删除
N=max(size(A));
a=2*Kf(A)/(N*(N-1));
B=zeros(1,n);
rank=randperm(N);
rank=rank(1:n);
for i=1:n
    k=rank(1:i);Aa=A;
    Aa(k,:)=[];Aa(:,k)=[];R=0;
    b=2*Kf(Aa)/((N-i)*(N-1-i));
    B(1,i)=(b-a)/a; 
end
end