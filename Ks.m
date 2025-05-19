function [KsMatrix] = Ks(A)
%衡量一个顶点的重要性，用Kf指数
N=size(A,2);KsMatrix=zeros(N,1);
a=2*Kf(A)/(N*(N-1));
for i=1:N
    disp(i)
    G=A;
    G(i,:)=[];G(:,i)=[];
    b=2*Kf(G)/((N-1)*(N-2));
    KsMatrix(i,1)= (b-a)/a;
end
end

