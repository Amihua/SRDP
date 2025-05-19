function [M] = MZ(G)
%用m次循环计算MZ(G)指数，对象G不是邻接矩阵，是matlab的graph格式
D=degree(G);MZ=0;
for i=1:size(G.Edges,1)
    t=G.Edges{i,:};
    MZ=MZ+1/(D(t(1))*D(t(2)));
end
end

