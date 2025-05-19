function [SG] = FW(G,p,seed)
%前沿游走策略
N = max(size(G.Nodes));
v_0 = randi([1,N]);
SeedNodes=[v_0];
while length(unique(SeedNodes))<seed
    v_0 = randi([1,N]);
    SeedNodes=[SeedNodes,v_0];
end
SeedNodes=unique(SeedNodes);
L=[SeedNodes];V=[SeedNodes];
Ld=degree(G,L);
while length(unique(V))<p*N
    t=randi([1,sum(Ld)]);
    for i=1:seed
        if t<= sum(Ld(1:i))
            break;
        end
    end
    neighb = neighbors(G,L(i));
    v_1 = neighb(randi([1,length(neighb)]));
    V = [V,v_1];
    L(i)=v_1;
    Ld(i)=degree(G,v_1);
end
idx = unique(V);
SG = subgraph(G,idx);
end