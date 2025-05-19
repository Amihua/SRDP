function [K] = Kftry(G)
n = max(size(G.Nodes));
K=0;
for i = 1:n
    d = degree(G,i);
    neib = neighbors(G,i);
    K=K+length(neib)*(1/d)+sum((1./degree(G,neib)));
end
K=K/2;

end

