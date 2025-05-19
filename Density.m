function [density] = Density(A)
%计算邻接矩阵图的密度
N=size(A,2);
density=sum(sum(A))/(N*(N-1));
end

