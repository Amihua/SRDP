function [SG,idx] = RW(G,p)
%图的随机游走;G为临接矩阵或者matlab的graph形式
if  strcmp(class(G),'double')
    n = size(G,2);
    v_0 = randi([1,n]);
    V = [v_0];
    H=G;
    while length(unique(V))<p*n
        t = find(G(v_0,:)==1);
        v_1 = t(randi([1,length(t)]));
        V = [V,v_1];
        v_0 = v_1;
    end
    t=[1:1:n];
    t(V)=[];
    H(t,:)=[];
    H(:,t)=[];
    SG=H;
elseif strcmp(class(G),'graph')
%     A = table2array(G.Edges);
%     N = unique(A); n = length(N);
%     v_0 = N(randi([1,n])); V = [v_0];
%     if size(A,2)==3
%         A(:,3)=[];
%     end
%     A=[A;A(:,2),A(:,1)];
%     while length(unique(V))<p*n
%         t = find(A(:,1)==v_0);
%         v_1 = A(t(randi([1,length(t)])),2);
%         V = [V,v_1];
%         v_0 = v_1;
%     end
    time = 0;
    N = max(size(G.Nodes));
%     kk=degree(G);k1=find(kk==max(kk));v_0=k1;
    v_0 = randi([1,N]); 
    V = [v_0]; %v_0 = randi([1,N]); 
    while length(unique(V))<p*N
        t = neighbors(G,v_0);
        v_1 = t(randi([1,length(t)]));
        V = [V,v_1];
        v_0 = v_1;
        
    end
    idx = unique(V);
    SG = subgraph(G, idx);
end
