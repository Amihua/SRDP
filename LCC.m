function [Lcc] = LCC(G)
%计算每个点的局部聚类系数
N = max(size(G.Nodes));
Lcc=zeros(1,N);
parfor i=1:N
    neighb = neighbors(G,i);
    if length(neighb)==1
        Lcc(i)=0;
    else
        index=[i;neighb];
        SG = subgraph(G,index);
        n = length(neighb);
        Lcc(i) = 2*(numedges(SG)-n)/(n*(n-1));
    end
end

