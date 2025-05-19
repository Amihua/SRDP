function [Matrix] = Conversion(A,p)
%p=1将数据转换为图的邻接矩阵,p=0将数据转为graph形式的图
if p==1
    Edge=size(A,1);
    N=max(max(A(:,1)),max(A(:,2)));
    Matrix=zeros(N,N);
    for i=1:Edge
        Matrix(A(i,1),A(i,2))=1;Matrix(A(i,2),A(i,1))=1;
    end
    Matrix(logical(eye(size(Matrix))))=0; %去自环，置矩阵的对角元素为0。
elseif p==0
    t1=A(:,1); t2=A(:,2);
    G=graph(t1,t2);
    Matrix=G;
end

