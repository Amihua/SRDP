function [SG] = SRW2(G,p,seed,lcc)
%根据点聚类系数来进行随机游走采样
Weight = zeros(size(G.Edges,1),1);
N=max(size(G.Nodes));
v_0 = randi([1,N]);
SeedNodes=[v_0];
while length(unique(SeedNodes))<seed
    v_0 = randi([1,N]);
    SeedNodes=[SeedNodes,v_0];
end
SeedNodes=unique(SeedNodes);
L=[SeedNodes];V=[SeedNodes];
while length(unique(V))<N*p
    for i=1:seed
        neighb = neighbors(G,L(i));
        edgeindex = findedge(G,L(i)*ones(length(neighb),1),neighb);
        edgeweight = find(Weight(edgeindex)==0);
        neighb = neighb(edgeweight);
        [LCC,sort_index] = sort(lcc(neighb));
        v_0 = neighb(sort_index(1));
        V=[V,v_0]; 
        edgeindex = findedge(G,L(i),v_0); 
        Weight(edgeindex) = 1;
        run = 0;
        while run <1
            neighb = neighbors(G,v_0);
            edgeindex = findedge(G,v_0*ones(length(neighb),1),neighb);
            edgeweight = find(Weight(edgeindex)==0);
            if sum(edgeweight)>0
                run = 1;
            else
                v_0 = randi([1,N]);
            end
        end
        L(i) = v_0;
    end
end
 idx = unique(V);
 SG = subgraph(G,idx);
end
