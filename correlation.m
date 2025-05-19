function [CorrelationaMatrix] = correlation(A)
% 用的是 Kendall rank correlation coefficient
N=size(A,2);T=size(A,1); CorrelationaMatrix=zeros(N,N);
for i=1:N-1
    for ii=i+1:N
        number = 0;
        for j=2:T
            for jj=1:j-1
                number = number+sign(A(j,i)-A(jj,i))*sign(A(j,ii)-A(jj,ii));
            end
        end
        CorrelationaMatrix(i,ii)=(2*number)/(T*T-1);
    end
end
CorrelationaMatrix=CorrelationaMatrix+CorrelationaMatrix'+diag(ones(N,1));
end

