function [ B ] = BA3( A,n )
%BA3是特意攻击结点度最高的顶点
%   这里ER随机图的randic 通过公式计算的
B=zeros(1,n);S1=Randic(A);m1=sum(sum(A))/2;N=size(A,2);
p1=(2*m1)/(N*(N-1));R1=0;b=[];
d = zeros(1,N);
for i=1:N;
    for ii=1:N;
        d(1,i)=d(1,i)+A(i,ii);
    end
end
[d,rank]=sort(d,'descend');
R1=N/(2*(N-1)*p1); a=S1/R1;
for i=1:n
    k=rank(1,1:i);;Aa=A;
    Aa(k,:)=[];Aa(:,k)=[];R=0;
    S=Randic(Aa);m=sum(sum(Aa))/2;p=(2*m)/((N-i)*(N-1-i));
    R=(N-i)/(2*(N-i)*p);b=S/R;
    %B(1,i)=(1-S/S1);
    B(1,i)=-(1-S/S1)*(R/R1);
    %B(1,i)=1-((N*N-1)*b)/((N-i)*(N-1-i)*a);
end

end

