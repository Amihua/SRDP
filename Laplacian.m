function [L] = Laplacian(A);
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
N=max (size(A));
d = zeros(1,N);
for i=1:N;
    for ii=1:N;
        d(1,i)=d(1,i)+A(i,ii);
    end
end
D=diag(d);
L=D-A;
end

