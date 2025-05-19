function [Out] = RWrange(G)
%G为graph类型，对图进行随机游走，研究得到子图的Kf值与母图的关系
range=[1:-0.05:0.1];
range=[range,0.08,0.05,0.03,0.01];
Kf_0 = Kf(G); value=zeros(1,23);
N = max(size(G.Nodes));
v_0 = randi([1,N]);  V = [v_0];
KF=zeros(1,23);
time1=clock;
KF(1,1)=Kf_0;
time2=clock;

%-------Randic-----------
% R=zeros(1,23); R_0 = Randic(G); Rvalue=zeros(1,23);
% R(1,1)=R_0;
%------------------------
for i=1:23
    if i<23
        while length(unique(V))<range(24-i)*N
            t = neighbors(G,v_0);
            v_1 = t(randi([1,length(t)]));
            V = [V,v_1];
            v_0 = v_1;
        end
    end
    idx = unique(V);
    SG = subgraph(G, idx);
    if i == 23
        value(1,1)=1;
%         Rvalue(1,1)=1;
    else
        aaa=Kf(SG);
        KF(1,24-i)=aaa;
        value(1,24-i)=aaa/Kf_0;
%         bbb=Randic(SG);
%         R(1,24-i)=bbb;
%         Rvalue(1,24-i)=bbb/R_0;
    end
end
d =degree(G); Out.degree = unique(d);
Out.count = histc(d,Out.degree);
Out.value = value;
Out.KF=KF;
Out.Time=etime(time2,time1);
% Out.R=R;
% Out.Rvalue=Rvalue;
end

