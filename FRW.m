function [SG] = FRW(G,p,seed)
%多重随机游走，然后用V诱导出子图
% seed为初始种子数量，即重数
N = max(size(G.Nodes));
v_0 = randi([1,N]);
SeedNodes=[v_0];
while length(unique(SeedNodes))<seed
    v_0 = randi([1,N]);
    SeedNodes=[SeedNodes,v_0];
end
SeedNodes=unique(SeedNodes);
L=[SeedNodes];V=[SeedNodes];
while length(unique(V))<p*N
    for i=1:seed
        neighb = neighbors(G,SeedNodes(i));
        v_1 = neighb(randi([1,length(neighb)]));
        V = [V,v_1];
        SeedNodes(i)=v_1;
    end
end
idx = unique(V);
SG = subgraph(G,idx);
end

