function [Randic] = Randic( A )
k=strcmp(class(A),'double');
if k==1
    %Randic=求和(1/du*dv) 当<u,v>∈E，重复计算乘以2
    N=max (size(A));
    d = zeros(1,N);
    for i=1:N;
        d(1,i)=sum(A(i,:));
        if d(1,i)~=0
            d(1,i)=1/d(1,i);
        end
    end
    
    D=diag(d);
    B=D*A*D;
    Randic=0;
    for v=1:N;
        Randic=Randic+sum(B(v,:));
    end
    Randic=Randic/2;
else
    Randic=0;
    t1=1./degree(A,A.Edges{:,1}(:,1));
    t2=1./degree(A,A.Edges{:,1}(:,2));
    t3=t1.*t2;
    Randic=sum(t3);
end

