function [B] = BA1( A,n )
%计算逐次减掉前n个点，A的S（G)变化
B=zeros(1,n);S1=Randic(A);m1=sum(sum(A))/2;N=size(A,2);
p1=(2*m1)/(N*(N-1));R1=0;
for i=1:20
    ER1=ERR(N,p1);
    r=Randic(ER1);
    R1=R1+r;
end
R1=R1/20; a=S1/R1;
for i=1:n
    A(1,:)=[];A(:,1)=[];R=0;
    S=Randic(A);m=sum(sum(A))/2;p=(2*m)/((N-i)*(N-1-i));
    for ii=1:20
        ER1=ERR(N-i,p);
        r=Randic(ER1);
        R=R+r;
    end
    R=R/20;b=S/R;
    %B(1,i)=(1-S/S1);
    B(1,i)=(1-S/S1)*(R/R1);
    %B(1,i)=1-((N*N-1)*b)/((N-i)*(N-1-i)*a);
end

end

