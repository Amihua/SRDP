function [ D ] = Degree( A )
%����һ��ͼ�������Ķȣ�����sort���У�
N=max (size(A));
D = zeros(1,N);
for i=1:N;
    for ii=1:N;
        D(1,i)=D(1,i)+A(i,ii);
    end
end
D=sort(D);

end

