function [Kf,AlgebraicConnectivity,p] = Kf( A )
%Kf�����ڽӾ���A��KFָ����AlgebraicConnectivity���صڶ�С����ֵ��p�����������ֵ
%   �˴���ʾ��ϸ˵��
if strcmp(class(A),'graph')
    t =table2array(A.Edges);
    if size(A,2)==3
        t(:,3) = [];
    end
    A = Conversion(t,1);
end
N=max(size(A));
G=graph(A);
bins=conncomp(G);
A=Laplacian(A);
E=eig(A);r=0;
if max(bins)>=2
    Kf=NaN;
%     AlgebraicConnectivity=0;
%     p=E(N);
else
    for i=2:N;
        r=r+1/E(i);
    end
    Kf=N*r;
%     AlgebraicConnectivity = E(2);
%     p=E(N);
end



