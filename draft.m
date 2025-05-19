n=30;m=20;
N=200;A=zeros(2,n*m);
for i=1:n*m;
    A(1,i)=Kf(adj);
    A(2,i)=2*Randic(adj)/N;
end

    N=N+1;
    adj=ER(N,0.08);
number=0;
for j=2:n*m
    for k=1:j-1
        number = number+sign(A(1,j)-A(1,k))*sign(A(2,i)-A(2,k));
    end
end
t=2*number/(n*m*(n*m-1));

%Global Clustering Coefficient 全局聚类系数的计算


%1.Kf 2.Randic 3.GCC 4.APL 5.diameter 6.代数连通度 7.密度 8.谱半径
LoopNum = 101;
M=zeros(101,8);N=1490;
M1=zeros(101,1);M2=zeros(101,1);M3=zeros(101,1);M4=zeros(101,1);
M5=zeros(101,1);M6=zeros(101,1);M7=zeros(101,1);M8=zeros(101,1);
parfor_progress(LoopNum);
parfor i=1:LoopNum
G=BA(N+i*10,5,4);
[M1(i,1),M6(i,1),M8(i,1)]=Kf(G); M2(i,1)=Randic(G); M3(i,1)=GCC(G);
[M4(i,1),M5(i,1)]=APL(G); M7(i,1)=Density(G);
parfor_progress;
end
M(:,1)=M1(:,1);M(:,2)=M2(:,1);M(:,3)=M3(:,1);M(:,4)=M4(:,1);
M(:,5)=M5(:,1);M(:,6)=M6(:,1);M(:,7)=M7(:,1);M(:,8)=M8(:,1);
parfor_progress(0);
%%---------------------------计算小世界网络-------------------------------
LoopNum = 101;
M=zeros(101,8);N=1490;
M1=zeros(101,1);M2=zeros(101,1);M3=zeros(101,1);M4=zeros(101,1);
M5=zeros(101,1);M6=zeros(101,1);M7=zeros(101,1);M8=zeros(101,1);
parfor_progress(LoopNum);
parfor i=1:LoopNum
G=WS(N+i*10,50,0.15);
[M1(i,1),M6(i,1),M8(i,1)]=Kf(G); M2(i,1)=Randic(G); M3(i,1)=GCC(G);
[M4(i,1),M5(i,1)]=APL(G); M7(i,1)=Density(G);
parfor_progress;
end
M(:,1)=M1(:,1);M(:,2)=M2(:,1);M(:,3)=M3(:,1);M(:,4)=M4(:,1);
M(:,5)=M5(:,1);M(:,6)=M6(:,1);M(:,7)=M7(:,1);M(:,8)=M8(:,1);
parfor_progress(0);

%%---------------------------计算ER图的MZ指数-------------------------------
P=[0,0.00005,0.00008,0.00011,0.0002,0.0003,0.0004,0.0005,0.0006,0.0007,0.0008,0.0009,0.01,0.02,0.023,0.026,0.03,0.033,0.036,0.04,0.042,0.045,0.048,0.05,0.052,0.054,0.058,0.06,0.06,0.07,0.08,0.085,0.09,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,0.95,1];
N=[25,50,100,200,400,800,1600];
M=zeros(55,7);
for k=1:30
    disp(k)
    for i=1:7
        n=N(i);
        for ii=1:55
            A=ER(n,P(ii));M(ii,i)=M(ii,i)+Randic(A);
        end
    end
end
m=M/30;
%------------------------------上述parfor并行处理----------------------------
N=[25,50,100,200,400,800,1600];
M1=zeros(55,1);M2=zeros(55,1);M3=zeros(55,1);M4=zeros(55,1);M5=zeros(55,1);
M6=zeros(55,1);M7=zeros(55,1);M=zeros(55,7);
parfor k=1:10
    for i=1:7
        n=N(i); 
        for ii=1:55
            A=ER(n,P(ii)); a=Randic(A);
            expr1=['M',num2str(i) '(ii,1)'];
            expr2=['M',num2str(i) '(ii,1)' '=eval(expr1)+a;'];
            eval(expr2);
        end
    end
end
%%-------------------------------标准化处理-------------------------------
mm=m;
for i=1:7
    mm(:,i)=m(:,i)/max(m(:,i));
end
%%-----------------------------连续上面的画图-------------------------------
for i=1:7
plot(P,m(:,i))
hold on
end
%-------------------------------dashed line为1-----------------------------
Fixed=zeros(7,2);
for i=1:7
    [maxvalue,index]=max(m(:,i));Fixed(i,1)=N(i);Fixed(i,2)=P(index);
end
%-------------------------------dashed line为1-----------------------------
MZ=zeros(55,2,7);
for i=1:7
    for ii=1:55
        MZ(ii,1,i)=N(i)*P(ii);MZ(ii,2,i)=mm(ii,i);
    end
end
%-------------------------------幂律分布画图大于np=1-----------------------------
for i=1:7
    [maxx,index]=max(m(:,i));
    exper=['Power',num2str(i) '=zeros(55-index-4,2);'];
    eval(exper);
    exper1=['Power',num2str(i) '(:,1)'  '=m(index+5:55,i);'];
    exper2=['Power',num2str(i) '(:,2)'  '=P(index+5:55);'];
    eval(exper1);
    eval(exper2);
end

for i=1:7
    exper1=['Power',num2str(i) '(:,1);'];
    exper2=['Power',num2str(i) '(:,2);'];
    plot(eval(exper2),eval(exper1))
    hold on
end
%-------------------------------幂律分布画图大于logN/n--------------------------
for i=1:7
    t=log(N(i))/N(i);
    t2=find(P(1,:)>t);
    exper1=['Power',num2str(i) '=zeros(length(t2),2);'];
    eval(exper1);
    exper2=['Power',num2str(i) '(:,1)' '=P(56-length(t2):55) ;'];
    eval(exper2);
    exper3=['Power',num2str(i) '(:,2)' '=m(56-length(t2):55,i); '];
    eval(exper3);
end
%--------------------------------------草稿1-----------------------------------
N=size(A,2);S1=Randic(A);RsMatrix=zeros(N,1);
m1=sum(sum(A))/2;p=(2*m1)/(N*(N-1));
R1=N/(2*(N-1)*p);p1=(2*m)/((N-1)*(N-2));
LoopNum = N;
parfor_progress(LoopNum);
parfor i=1:LoopNum
    G=A;
    G(i,:)=[];G(:,i)=[];
    S=Randic(G);m=sum(sum(G))/2;
    R=(N-1)/(2*(N-2)*p1);
    RsMatrix(i,1)=(1-S/S1)*(R/R1);
    parfor_progress;
end
parfor_progress(0);
%--------------------------------------Randci算法加强--------------------------、
%版本1
D=degree(G);MZ=0;
LoopNum = size(G.Edges,1);
parfor_progress(LoopNum);
parfor i=1:LoopNum
    t=G.Edges{i,:};
    MZ=MZ+1/(D(t(1))*D(t(2)));
    parfor_progress;
end
parfor_progress(0);
%版本2 成功版本
MZ=0;
t1=1./degree(G,G.Edges{:,1}(:,1));
t2=1./degree(G,G.Edges{:,1}(:,2));
t3=t1.*t2;
MZ=sum(t3)
%-----------------------------基础语句(热力图，查NaN，散点)----------------------------
isnan(A) %查找A中NaN的位置
isinf(A) %查找A中Inf的位置
p=plot(G,'Layout','force'); %画图使得位置集中
ucc = centrality(G,'closeness');
p.NodeCData = ucc;  
colormap jet
colorbar
 s=scatter(8,7,20,'d','k','LineWidth',1);
%--------------------------------------基础语句----------------------------
x=[];y=[];
for i=1:1038
    if(isnan(kk(i))==1)
        x=[x,p.XData(i)];
        y=[y,p.YData(i)];
    end
end
hold on
s=scatter(x,y,6,'d','k');
%-----------------------------------计算ER局部性质----------------------------
%1.MZC 2.ERC 3.Clos. 4.Betw. 5. Eig.Centr 6.PageR. 7.Degree
A=BA(2500,5,4);
G=graph(A);
M=zeros(2500,7);
M(:,2)=Ks(A);
M(:,1)=Rs(G);M(:,3)=centrality(G, 'closeness' );
M(:,4)=2*centrality(G, 'betweenness' )/(2498*2499);
M(:,5)=centrality(G, 'eigenvector' );
M(:,6)=centrality(G, 'pagerank' );M(:,7)=centrality(G, 'degree');

%-------------------------------生成相对应真实网络的模拟图----------------
LoopNum=100;
ERkf=zeros(100,1);parfor_progress(LoopNum);
parfor i=1:LoopNum
    A=ER(1038,0.0024);
    ERkf(i,1)=2*Kf(A)/(1038*1037);
    parfor_progress;
end
parfor_progress(0);
ERkf=sum(ERkf)/100;

A=BA(1038,5,2);
m=1303;k=floor(sum(sum(A))/2-m);%取整数
for k=1038-k+1:1038
    a=find(A(k,:)==1);
if (rand(1,1)<0.5)
    A(k,a(1))=0;A(a(1),k)=0;
else
    A(k,a(2))=0;A(a(2),k)=0;
end
end
%-------------------生成与真实网络有相同规模的的WS小世界网络----------------    
A=WS(1038,4,0.15);
[d,index]=sort(-sum(A));
m=1303;k=floor(sum(sum(A))/2-m);%取整数
c=1;
for i=1:k
    G=A;
    a=find(A(index(c),:)==1);
    l=length(a);
    t=1;
    G(index(c),a(t))=0;G(a(t),index(c))=0;
    while isnan(Kf(G))
        if t <l
            t=t+1;
        elseif c<1037
            c=c+1;
            t=1;
        else
           c=1;
           [d,index]=sort(-sum(A));
        end
        G=A;
        a=find(A(index(c),:)==1);
        l=length(a);
        G(index(c),a(t))=0;G(a(t),index(c))=0;
    end
    A(index(c),a(t))=0;A(a(t),index(c))=0;
    if c<400
        c=c+1;
    else
        c=1
    end
end
%------------------------------------不同局部属性的排名-----------------
M=zeros(15,6);
for i=1:15
    M(i,1)=find(a2==index(i));M(i,2)=find(b2==index(i));
    M(i,3)=find(c2==index(i));M(i,4)=find(d2==index(i));
    M(i,5)=find(e2==index(i));M(i,6)=find(f2==index(i));
end

N=4941;a=2*Kf(A)/(N*(N-1));
parfor i=2501:3500
    K=A;
    K(i,:)=[];K(:,i)=[];
    b=2*Kf(K)/((N-1)*(N-2));
    M2(i,1)= (b-a)/a;
end

rank=[];
for i=1:15
    rank=[rank,find(b2==a2(i))];
end
%-----------------------------网络顶点序号重新排列----------------
y=unique(A);
for i=1:length(y)
    A(A==y(i))=i;
end
%-----------------------------找出图最大的连通分量----------------
[bin,binsize] = conncomp(G,'Type','weak')
idx = binsize(bin) == max(binsize);
SG = subgraph(G, idx);
plot(SG)
%--------------------------笔记------------------------------------
%1000的ER规模下降 
1         0.94914429 0.89885263 0.84910858 0.79873133 0.74867632
  0.69846365 0.64850092 0.59848771 0.54883701 0.49862065 0.44844403
  0.3981664  0.3486883  0.29897565 0.24876429 0.19897958 0.14932731
  0.09978068 0.04920449  %度同配性: -0.00213316
  
%2000的ER规模下降
1         0.94909386 0.8978605  0.84782013 0.79671863 0.74708726
  0.69772463 0.64695559 0.59816851 0.54748866 0.49746576 0.44770712
  0.39775611 0.34823989 0.2986513  0.24861566 0.19946139 0.14930353
  0.0993272  0.04885182  %度同配性: -0.00010163
 
 %3000的ER规模下降
 1         0.94920399 0.89682133 0.84658669 0.7939165  0.74402824
  0.69570162 0.64495345 0.59695956 0.54570041 0.49566765 0.44605536
  0.39588185 0.34843202 0.29913652 0.24775926 0.19875175 0.15025464
  0.09672635 0.04748082  %度同配性: -0.00106788
  
 %1000的BA规模下降
 1         0.91770764 0.84294343 0.77092452 0.70214429 0.63816235
  0.57762641 0.52297303 0.46758974 0.41751875 0.36453988 0.31628061
  0.27165029 0.23020785 0.1897812  0.15024718 0.11258406 0.07945719
  0.05045496 0.02462294  %度同配性: 0.00368089
 %2000的BA规模下降
 1         0.91943635 0.84335451 0.77401541 0.7059316  0.64224963
  0.5826329  0.52466808 0.46913555 0.41685695 0.37037443 0.32274318
  0.27705716 0.23529986 0.19765864 0.15795362 0.11909815 0.08703382
  0.05664883 0.02613883  %度同配性: 0.00356926
  %3000的BA规模下降
 1         0.92327723 0.84835583 0.78060591 0.71384065 0.65151705
  0.59647615 0.54001865 0.48767651 0.43512908 0.38892565 0.33884606
  0.29381078 0.25089969 0.21350633 0.17172147 0.13702031 0.10056559
  0.06125547 0.02789903  %度同配性: -0.00397246
 %1000的WS规模下降
 1.         0.95214799 0.90447551 0.85685833 0.80837636 0.76043205
  0.71188521 0.66373757 0.61557268 0.56638347 0.51769267 0.46900211
  0.42013937 0.37086261 0.32207138 0.27048334 0.22039094 0.16768458
  0.10833131 0.0505811
 %2000的WS规模下降
 1.         0.95277184 0.90408973 0.85682596 0.80852838 0.7603985
  0.71293626 0.66449601 0.61656996 0.56757706 0.51902405 0.4699784
  0.4200878  0.37305525 0.32314204 0.27036808 0.21560716 0.16390642
  0.10818431 0.04467744
 %3000的WS规模下降
 1.         0.95309536 0.90406355 0.85699647 0.80809118 0.75945534
  0.71166974 0.66245706 0.61463751 0.56469346 0.51678364 0.46755951
  0.41792856 0.36452271 0.31417744 0.26571497 0.2127426  0.15594483
  0.09934803 0.03988943 %度同配性: 7.38570297e-06 -5.47157153e-03 -3.61268108e-03
 %8000网络的规模下降
1         0.84101088 0.72300632 0.6219346  0.53042202 0.44910989
  0.38264544 0.32188777 0.26477562 0.2169541  0.17672801 0.14060747
  0.10711561 0.08193204 0.06227362 0.04455814 0.03010143 0.01841159
  0.01096976 0.00364703 %度同配性0.2389153108042067 平均聚类系数0.4815641520261667
 %4000网络的规模下降
1         0.88674872 0.7997958  0.71063328 0.63604466 0.56558745
  0.52772368 0.44992623 0.36837783 0.31136505 0.30989525 0.22770608
  0.18801681 0.13728839 0.10633447 0.07787622 0.04365866 0.02552373
  0.02602244 0.00241857 %度同配性0.0034569877442048825 平均聚类系数0.08010361108159714

 %-------------------ER随机图的电阻与p,n的关系-----------------------------
 for i=1:21
     for j=1:490
         G=ER(n(i),p(j))
         A(i,j)=Kf(G)
     end
 end
 x=[]; y=[];
 for i=1:11
     a=i*ones(1,23);
     x=[x,a];
 end
 for i=1:11
     y=[y,p];
 end
 z=[];
 for i=1:11
     z=[z,A(i,:)];
 end    
for i=1:41
    z2(1,i)=Kf(ER(n2(i),0.5))
end
%---------------计算10次不同采样程度和不同采样方法的效果----------------------------------
scale=[1,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1,0.05,0.01];
SRWC=zeros(10,10);SRWP=zeros(10,10);SRWT=zeros(10,10);SRWR=zeros(10,10);SRWTime=zeros(10,10);
parfor i=1:10
i
e=Efficiency(G,k,'SRW');
SRWC(i,:)=e.c_error;
SRWP(i,:)=e.p_error;
SRWT(i,:)=e.T;
SRWR(i,:)=e.R;
SRWTime(i,:)=e.Time;
end
%-------------------------计算特定抽样规模--------------------------
d=degree(G);count=histc(d,unique(d));
a1=log10(unique(d));b1=log10(count);
t1=sum(polyfit(a1,b1,1));

yyy0=zeros(30,1);
yyy1=zeros(30,1);
yyy2=zeros(30,1);
yyy3=zeros(30,1);
parfor i=1:30
g=RW(G,0.3);Kf_0=Kf(g);Kf_0/k;
gg=RW(g,0.3);Kf_1=Kf(gg);
while isnan(Kf_1)
    gg=RW(g,0.3);
    Kf_1=Kf(gg);
end 
value=Kf_1/Kf_0;
d=degree(g);count=histc(d,unique(d));
a2=log10(unique(d));b2=log10(count);
t2=sum(polyfit(a2,b2,1));
t=(t1-t2)/t1; R=Kf_0/value;
RR=R/(1-t);
yyy0(i)=abs((k-RR)/k);
RR=R/(1-0.5*t);
yyy1(i)=abs((k-RR)/k);
RR=R/(1-0.1*t);
yyy2(i)=abs((k-RR)/k);
yyy3(i)=abs((k-R)/k)
end
%-----------------------计算ER图的KF下降---------------------------
Value=zeros(1,23);
parfor 1:50
    G=graph(ER(8000,0.01));
    e=RWrange(G);
    Value = Value+e.value;
end
%-------------------------修正下界曲线-----------------------------
d=degree(G);count=histc(d,unique(d));
a1=log10(unique(d));b1=log10(count);
t1=sum(polyfit(a1,b1,1));
P=[0.95:-0.05:0.05];
Y=zeros(1,19);
for i=1:19
    i
    for k=1:10
        g=RW(G,P(i));
        gg=RW(g,P(i));
        Kf_g=Kf(g);Kf_gg=Kf(gg);
        value=Kf_gg/Kf_g;
        d=degree(g);count=histc(d,unique(d));
        a2=log10(unique(d));b2=log10(count);
        t2=sum(polyfit(a2,b2,1));
        t=(t1-t2)/t1;
        Kf_1=value*(1-t);
        Y(i)=Y(i)+Kf_1;
    end
    Y(i)=Y(i)/10;
end
%----------------40次抽样----------------------
Y1_01=zeros(1,40);Y1_05=zeros(1,40);Y1_1=zeros(1,40);
Y2_01=zeros(1,40);Y2_05=zeros(1,40);Y2_1=zeros(1,40);
Y3_01=zeros(1,40);Y3_05=zeros(1,40);Y3_1=zeros(1,40);
P=[0.3,0.2,0.1];
for i=1:3
    parfor ii=1:40
        g=RW(G,P(i));
        kf_g = Kf(g);
        gg1=SRW(g,P(i),0.1);
        gg2=SRW(g,P(i),0.5);
        gg3=SRW(g,P(i),1);
        kf_1=Kf(gg1); kf_2=Kf(gg2);kf_3=Kf(gg3);
        while isnan(kf_1)
            gg1=SRW(g,P(i),0.1);
            kf_1=Kf(gg1);
        end
        while isnan(kf_2)
            gg2=SRW(g,P(i),0.5);
            kf_2=Kf(gg2);
        end
        while isnan(kf_3)
            gg3=SRW(g,P(i),1);
            kf_3=Kf(gg3);
        end
        if i==1
            Y1_01(ii)=abs((((kf_g*kf_g)/kf_1)-k))/k;
            Y1_05(ii)=abs((((kf_g*kf_g)/kf_2)-k))/k;
            Y1_1(ii)=abs((((kf_g*kf_g)/kf_3)-k))/k;
        elseif i==2
            Y2_01(ii)=abs((((kf_g*kf_g)/kf_1)-k))/k;
            Y2_05(ii)=abs((((kf_g*kf_g)/kf_2)-k))/k;
            Y2_1(ii)=abs((((kf_g*kf_g)/kf_3)-k))/k;
        elseif i==3
            Y3_01(ii)=abs((((kf_g*kf_g)/kf_1)-k))/k;
            Y3_05(ii)=abs((((kf_g*kf_g)/kf_2)-k))/k;
            Y3_1(ii)=abs((((kf_g*kf_g)/kf_3)-k))/k;
        end
    end
end

R1=zeros(1,40);R2=zeros(1,40);R3=zeros(1,40);
for i=1:3
    parfor ii=1:40
        g=RW(G,P(i));
        gg=RW(g,P(i));
        kf_g=Kf(g);kf_gg=Kf(gg);
        if i==1
            R1(ii)= abs((((kf_g*kf_g)/kf_gg)-k)/k);
        elseif i==2
            R2(ii)= abs((((kf_g*kf_g)/kf_gg)-k)/k);
        elseif i==3
            R3(ii)= abs((((kf_g*kf_g)/kf_gg)-k)/k);
        end
    end
end


g=RW(G,0.3);
gg=SRW(g,0.3,1);
kf_g=Kf(g);
kf_gg=Kf(gg);
abs((((kf_g*kf_g)/kf_gg)-k)/k)

Y1_01c=zeros(1,4);
for i=1:40
    if Y1_01(i)<0.4
        Y1_01c(4)=Y1_01c(4)+1;
    end
    if Y1_01(i)<0.3
        Y1_01c(3)=Y1_01c(3)+1;
    end
    if Y1_01(i)<0.2
        Y1_01c(2)=Y1_01c(2)+1;
    end
    if Y1_01(i)<0.1
        Y1_01c(1)=Y1_01c(1)+1;
    end   
end

%---------------多种采样技术对图进行Kf估测-----------------
RW1=zeros(5,40);FS1=zeros(5,40);MRW1=zeros(5,40);
SRW05=zeros(5,40);SRW1=zeros(5,40);
p=[0.5,0.4,0.3,0.2,0.1];
N=size(G.Nodes,1);
c=0;
for i=1:5
    c=c+1;
    parfor ii=1:40
        time = [i,ii];
        disp(time) 
        g=RW(G,p(i));
        gg1=RW(g,p(i));
        gg2=FRW(g,p(i),N*p(i)*p(i)*0.01);
        gg3=FW(g,p(i),N*p(i)*p(i)*0.01);
        gg4=SRW(g,p(i),0.5);
        gg5=SRW(g,p(i),1);
        kf_g=Kf(g);kf_gg1=Kf(gg1);kf_gg2=Kf(gg2);
        kf_gg3=Kf(gg3);kf_gg4=Kf(gg4);kf_gg5=Kf(gg5);
        while isnan(kf_gg2)
            gg2=FRW(g,p(i),N*p(i)*p(i)*0.01);
            kf_gg2=Kf(gg2);
        end
        while isnan(kf_gg3)
            gg3=FW(g,p(i),N*p(i)*p(i)*0.01);
            kf_gg3=Kf(gg3);
        end
        while isnan(kf_gg4)
            gg4=SRW(g,p(i),0.5);
            kf_gg4=Kf(gg4);
        end
        while isnan(kf_gg5)
            gg5=SRW(g,p(i),1);
            kf_gg5=Kf(gg5);
        end
        RW1(c,ii)=(kf_g*kf_g)/kf_gg1;RW1(c,ii)=abs(RW1(c,ii)-k)/k;
        MRW1(c,ii)=(kf_g*kf_g)/kf_gg2;MRW1(c,ii)=abs(MRW1(c,ii)-k)/k;
        FS1(c,ii)=(kf_g*kf_g)/kf_gg3;FS1(c,ii)=abs(FS1(c,ii)-k)/k;
        SRW05(c,ii)=(kf_g*kf_g)/kf_gg4;SRW05(c,ii)=abs(SRW05(c,ii)-k)/k;
        SRW1(c,ii)=(kf_g*kf_g)/kf_gg5;SRW1(c,ii)=abs(SRW1(c,ii)-k)/k;
    end
end
%------------------十次采样估算以及时间----------------------------------
p=[0.5,0.4,0.3,0.2,0.1];
SRW05H=zeros(1,5); SRW05h=zeros(1,5);
for i=1:5
    H=zeros(1,10);
    h=zeros(1,10);
    parfor ii=1:10
        Time=[i,ii]
        disp(Time)
        g=RW(G,p(i));
        gg=SRW(g,p(i),0.5);
        kf_g=Kf(g);kf_gg=Kf(gg);
        while isnan(kf_gg)
            gg=SRW(g,p(i),0.5);
            kf_gg=Kf(gg);
        end
        h(1,ii)=(kf_g*kf_g)/kf_gg;
        H(1,ii)=abs(h(1,ii)-k)/k;
    end
    SRW05H(1,i)=sum(H)/10;
    SRW05h(1,i)=abs(sum(h)/10-k)/k;
end
%H是十次误差平均，h全部kf之和平均减去

n=200;
B=zeros(100,n);
parfor j=1:100
    j
    G=ER(2500,0.08);g=graph(G);
    R0=Randic(graph(G));e0=(2500*2500)/(4*size(g.Edges,1));
    d=degree(g);[a,rank]=sort(-d);
    b=randperm(300);
    BB=[];
    for k=1:n
        A=G;remove=rank(b(1:k));
        A(remove,:)=[];A(:,remove)=[];
        A=graph(A);
        R1=Randic(A);m=size(A.Edges,1);e1=(2500-k)*(2500-k)/(4*m);
        BB=[BB,(R1/R0-1)*(e1/e0)];
    end
    B(j,:)=BB;
end
    
%---------特意-------------------

n=200;
B=zeros(100,n);
d=degree(g);[a,rank]=sort(-d);
kf0 = 2*Kf(G)/(2500*2499);
for j=1:10
    j
    b=randperm(350);
    BB=[];
    for k=1:n
        A=G;remove=rank(b(1:k));
        A(remove,:)=[];A(:,remove)=[];
        kf1=2*Kf(A)/((2500-k)*(2499-k));
        BB=[BB,(kf1-kf0)/kf1];
    end
    B(j,:)=BB;
end
%------------------故意KF---------------------      
n=200;
B=zeros(100,n);
d=degree(g);[a,b]=sort(-d);
kf0 = 2*Kf(G)/(2500*2499);
parfor j=1:100
    j
    BB=[];
    for k=1:n
        A=G;remove=b(1:k);
        A(remove,:)=[];A(:,remove)=[];
        kf1=2*Kf(A)/((2500-k)*(2499-k));
        BB=[BB,(kf1-kf0)/kf1];
    end
    B(j,:)=BB;
end
        
