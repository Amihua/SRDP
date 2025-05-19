function [ L,s ] = NL( A )
%图G标准化拉普拉斯矩阵求法 L=I-D^(-1/2)AD^(-1/2)
%   此处显示详细说明
N=max(size(A));
I=diag(ones(N,1));
d = zeros(1,N);
for i=1:N;
    for ii=1:N;
        d(1,i)=d(1,i)+A(i,ii);
    end
end
D=diag(d);
D=D^(-1/2);
L=I-D*A*D;
s=(eig(L)-1).*(eig(L)-1);
s=sum(s)/N;
end

