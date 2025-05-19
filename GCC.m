function[ GCC ]= GCC(adj)
%Global Clustering Coefficient 全局聚类系数的计算
n=size(adj,2);GCC=0;C1=0;C2=0;
for i=1:n
    C2=C2+sum(adj(i,:))*(sum(adj(i,:))-1);
    for j=1:n
        for k=1:n
            C1=C1+adj(i,j)*adj(j,k)*adj(k,i);
        end
    end
end
GCC=C1/C2;
            