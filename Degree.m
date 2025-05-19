function [ D ] = Degree( A )
%计算一个图各个结点的度，并用sort排列；
N=max (size(A));
D = zeros(1,N);
for i=1:N;
    for ii=1:N;
        D(1,i)=D(1,i)+A(i,ii);
    end
end
D=sort(D);

end

