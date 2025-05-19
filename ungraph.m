function [New_G] = ungraph(G)
%将matlab的graph转换为邻接矩阵的形式
A = table2array(G.Edges);
New_G = Conversion(A,1);

% edge_number = max(size(G.Edges(:,1)));
% N = max(size(G.Nodes));
% table = zeros(edge_number,2);
% New_G = zeros(N,N);
% for i=1:edge_number
%     t = table2array(G.Edges(i,1));
%     New_G(t(1),t(2))=1;
%     New_G(t(2),t(1))=1;
%     table(i,1)=t(1);
%     table(i,2)=t(2);
% end

