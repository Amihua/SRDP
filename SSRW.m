function [SG] = SSRW(G,p)
%图的随机游走;G为临接矩阵或者matlab的graph形式
N = max(size(G.Nodes));
Neighb=cell(N,1);
Degree=zeros(N,1);
for i = 1:N
    t = neighbors(G,i);
    Neighb{i}= t;
    Degree(i) = length(t);
end
v_0 = randi([1,N]);
V = [v_0]; %v_0 = randi([1,N]);
while length(unique(V))<p*N
    t = Neighb{v_0};
    if rand(1,1)>(1-p)*0.5
        v_1 = t(randi([1,length(t)]));
        V = [V,v_1];
    else
        [Degre, sort_index] = sort(-Degree(t));
        v_1 = t(sort_index(1));
        V = [V,v_1];
    end
    v_0 = v_1;
    
end
idx = unique(V);
SG = subgraph(G, idx);
end