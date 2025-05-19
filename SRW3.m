function [SG,time] = SRW3(G,p,seed)
%size为抽样的大小，seed初始种子的大小，p选取概率
%半随机半确定的抽样策略。
%3代版本用的是matlab自带的rmedges函数。
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
    N=max(size(G.Nodes));
    v_0 = randi([1,N]);
    SeedNodes=[v_0];
    while length(unique(SeedNodes))<seed
        v_0 = randi([1,N]);
        SeedNodes=[SeedNodes,v_0];
    end
    SeedNodes=unique(SeedNodes);
    L=[SeedNodes];V=[SeedNodes];
    time=0;
    while length(unique(V))<N*p
        for i=1:seed
            neighb = neighbors(G,L(i));
            if rand(1,1)>1-p
                v_0 = neighb(randi([1,length(neighb)]));
            else
                [Degree, sort_index] = sort(-degree(G,neighb));
                v_0 = neighb(sort_index(1));
                V=[V,v_0];
            end
            time1=clock;
            G = rmedge(G,L(i),v_0);
            time2=clock;
            run = 0;
            while run <1
                if degree(G,v_0)>0;
                    run = 1;
                else
                    v_0 = randi([1,N]);
                end
            end
            time=time+etime(time2,time1);
            
            L(i) = v_0;
        end
    end
    idx = unique(V);
    SG = subgraph(G,idx);
end
end
