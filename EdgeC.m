function [Cut] = EdgeC(A)
%计算无向邻接图的边连通度
%   此处显示详细说明
N=size(A,2);
if min(sum(A))==1
    Cut=1;
else
    for i=1:N-2
        for ii=1:N-1-i
        if A(1,ii)
end

