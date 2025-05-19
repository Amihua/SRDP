n=max(max(A(:,1)),max(A(:,2)));
G=zeros(n,n);
for i=1:2596
    G(A(i,1),A(i,2))=1;G(A(i,2),A(i,1))=1;
end
g=graph(G);


A=zeros(25,2);N=200;
for i=1:25;
    N=N+20;
    G=ER(N,0.08);
    A(i,1)=Kf(G);A(i,2)=Randic(G);
end

A=zeros(25,1);B=zeros(25,1);N=200;
parfor i=1:25;
    N=200+i*20;
    G=BA(N,5,4);
    A(i,1)=Kf(G);B(i,1)=2*sum(sum(G))*Randic(G)/(N*N);
end