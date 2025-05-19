function [RsMatrix] = Rs(A)
%Rs用来衡量每个顶点的重要性
k=strcmp(class(A),'double');
if k==1
    N=size(A,2);S1=Randic(A);RsMatrix=zeros(N,1);
    m1=sum(sum(A))/2;p=(2*m1)/(N*(N-1));
    R1=N/(2*(N-1)*p);
    for i=1:N
        G=A;
        G(i,:)=[];G(:,i)=[];
        S=Randic(G);m=sum(sum(G))/2;
        p1=(2*m)/((N-1)*(N-2));
        R=(N-1)/(2*(N-2)*p1);
        RsMatrix(i,1)=-(1-S/S1)*(R/R1);
    end
else
    N=size(A.Nodes,1);S1=Randic(A);RsMatrix=zeros(N,1);
    m1=size(A.Edges,1);p=(2*m1)/(N*(N-1));
    R1=N/(2*(N-1)*p);t=(N-1)*(N-2);
    for i=1:N
        G=A;
        G = rmnode(G,i);
        S=Randic(G);m=size(G.Edges,1);
        p1=(2*m)/(t);
        R=(N-1)/(2*(N-2)*p1);
        RsMatrix(i,1)=-(1-S/S1)*(R/R1);
    end
end

