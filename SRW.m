function [SG,V] = SRW(G,p,k)
%size为抽样的大小，seed初始种子的大小，p选取概率
%半随机半确定的抽样策略。
seed=1;
if strcmp(class(G),'double')
    n = size(G,2);
    v_0 = randi([1,n]);
    V = [v_0];
    H=G;time=0;
    while length(unique(V))<p*n
        if (rand(1,1)>2)
            t = find(H(v_0,:)==1);
            j = size(t,2);
            v_1 = t(randi([1,j]));
            V = [V,v_1];
            H(v_0,v_1)=0; H(v_1,v_0)=0;
            while sum(H(v_1,:)) == 0
                v_1 = randi([1,n]);
            end
            v_0 = v_1;
        else
            D=[];
            t = find(H(v_0,:)==1);
            time1 = clock;
            for i=1:length(t)
                D = [D,length(find(H(t(i),:)==1))];
            end
            time2 = clock;
            [deg,index] = sort(-D);
            % v_1 = t(randi([1,length(t)]));
            v_1 = t(index(1));
            V = [V,v_1];
            H(v_0,v_1)=0; H(v_1,v_0)=0;
            time = time+etime(time2,time1);
            while sum(H(v_1,:)) == 0
                v_1 = randi([1,n]);
            end
            v_0 = v_1;
        end
    end
    V=unique(V);
    t=[1:1:n];
    t(V)=[];
    G(t,:)=[];
    G(:,t)=[];
    SG=G;
elseif strcmp(class(G),'graph')
    step = 0;time=0;
    Weight = zeros(size(G.Edges,1),1);
    N=max(size(G.Nodes));Node=[1:1:N];
    v_0 = randi([1,N]);
    SeedNodes=[v_0];
    Neighb=cell(N,1);
    Degree=zeros(N,1);
    NeighbEdge = cell(N,1);
    for i = 1:N
        t = neighbors(G,i);
        Neighb{i}= t;
        NeighbEdge{i}=findedge(G,i,t);
        Degree(i) = length(t);
    end
    while length(unique(SeedNodes))<seed
        v_0 = randi([1,N]);
        SeedNodes=[SeedNodes,v_0];
    end
    SeedNodes=unique(SeedNodes);
    L=[SeedNodes];V=[SeedNodes];
    while length(unique(V))<N*p
        for i=1:seed
            neighb = Neighb{L(i)};
            edgeindex = NeighbEdge{L(i)};
            edgeweight = find(Weight(edgeindex)==0);
            neighb = neighb(edgeweight);
            if rand(1,1)>(1-p)*k
                v_0 = neighb(randi([1,length(neighb)]));
                V=[V,v_0];
            else
                [Degre, sort_index] = sort(-Degree(neighb));
                v_0 = neighb(sort_index(1));
%                 Q= length(sort_index);
%                 if Q>3
%                     v_0 = neighb(sort_index(randi([1,3])));
%                 else
%                     v_0 = neighb(sort_index(randi([1,Q])));
%                 end
                V=[V,v_0];
            end
            edgeindex = findedge(G,L(i),v_0);
            Weight(edgeindex) = 1;
%             Degree([L(i),v_0])=Degree([L(i),v_0])-1;
%             Node=setdiff(Node,v_0);
            run = 0;
            while run <1
                neighb = Neighb{v_0};
                edgeindex = NeighbEdge{v_0};
                step = step+1;
                edgeweight = find(Weight(edgeindex)==0);
                if isempty(edgeweight)
                    v_0 = randi([1,N]);
%                     v_0 = Node(randi([1,length(Node)]));
                else
                    run = 2;
                end
            end
            L(i) = v_0;
            V=[V,v_0];
        end
    end
    idx = unique(V);
    SG = subgraph(G,idx);
end
end

